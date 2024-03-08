#!/bin/bash
# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root." | logger
  exit 1
fi

# Set the compression flag
compression=true

# Set the encryption password 
encryption_password="ee4KfInoequanGirpgsehVf"

# Mount the backup folder check lsblk and edit line 16 with your configuration do not use sda or sdb these names may interchange 
# use uuid of the disk then it doesn't matter how the disk identified using sda or adb
if ! grep -qs '/backup/bkmp ' /proc/mounts; then
    if ! udo mount UUID=0a92f4f4-cbe7-4c65-bdf7-59b7f976b0b7 /backup/bkmp; then
        echo "Failed to mount backup folder" | logger
        exit 1
    fi
fi

# GPG encryption settings with a password file
password_file="/usr/local/bin/backup_script/password_file.txt"
echo "$encryption_password" > "$password_file"
chmod 600 "$password_file"

# Directories to include in the system backup
backup_dirs=(
    "/etc"           # for system-wide configuration files.
    "/home"          # for user data and configuration.
    "/var" 
    "/root"          # for the root user's home directory.
    "/usr/local/bin" 
    "/srv" 
    "/opt"           # Third-party apps
    
    # Add other directories you want to include
)

# Directories to exclude from the backup 
exclude_dirs=(
    #"/var/lib/docker"
    "/tmp"           # Exclude temporary directories
    "/var/tmp"       # Exclude temporary directories
)

# Maximum file size to exclude (1 GB)
max_file_size=1G

# Destination directory for the system backup. Its not intended for this drive to be connected during working hours - protect from ransomware
backup_dir="/backup/bkmp"

# Date format for backup folder and log files
date_format=$(date +"%Y%m%d_%H%M%S")

# Create backup folder with date and time
backup_folder="$backup_dir/system_backup_${date_format}"
mkdir -p "$backup_folder"

# Log file to store rsync output
log_file="$backup_folder/rsync_${date_format}.log"

# Log file for skipped files
skipped_log_file="$backup_folder/skipped_files_${date_format}.log"

gpg_command="gpg -c --cipher-algo AES256 --batch --passphrase-file $password_file"  # Adjust encryption options as needed
gpg_verify_command="gpg --decrypt --batch --passphrase-file $password_file"  # Verification command

# Start time
start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Backup started at $start_time" >> "$log_file"
logger "Backup started at $start_time"  # Send start time to syslog

# Rsync command for each directory, excluding directories
for dir in "${backup_dirs[@]}"; do
    if ! rsync -a --delete --exclude-from=<(printf '%s\n' "${exclude_dirs[@]}") --max-size=$max_file_size "$dir" "$backup_folder" --log-file="$log_file" --stats 2>&1; then
        echo "Failed to rsync $dir"                                                   
        
    fi
done

# Filter out the skipped files and log them
grep "skipping non-regular file" "$log_file" > "$skipped_log_file"

# End time
end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Backup ended at $end_time" >> "$log_file"

# Number of files backed up and skipped
num_files_backed_up=$(grep "Number of regular files transferred" "$log_file" | awk '{print $NF}')
num_files_skipped=$(wc -l < "$skipped_log_file")
echo "Number of files backed up: $num_files_backed_up" >> "$log_file"
echo "Number of files skipped: $num_files_skipped" >> "$log_file"

# Logging
echo "Backup completed successfully" >> "$log_file"
logger "Backup completed successfully"  # Send completion message to syslog

# Log number of files backed up and skipped to syslog
logger "Number of files backed up: $num_files_backed_up"
logger "Number of files skipped: $num_files_skipped"


# Copy the rsync log file to /usr/local/bin/backup_scripts use for debugging
if ! cp "$log_file" "/usr/local/bin/backup_script/"; then
    echo "Failed to copy rsync log file" | logger
    
fi

# Compression if enabled
if [ "$compression" = true ]; then
    if ! tar -czf "$backup_folder.tar.gz" -C "$backup_folder" .; then
        echo "Failed to compress backup folder" | logger
        
    fi
    rm -rf "$backup_folder"
    backup_folder="$backup_folder.tar.gz"
fi

# Encrypt the system backup folder with the specified password
if ! $gpg_command "$backup_folder"; then
    echo "Failed to encrypt backup folder" | logger
    
fi

# Compute SHA-256 hash of the encrypted system backup folder
hash_file="$backup_folder-backup_hash.sha256"
if ! sha256sum "$backup_folder.gpg" > "$hash_file"; then
    echo "Failed to compute SHA-256 hash" | logger
   
fi

# clean up the backup directory by deleting all files
# except for the .gpg files and the log file.

# Find all files in the backup directory that are not .gpg files or the log file
# and delete them. If the cleanup fails, log an error message.

if ! find "$backup_dir" -type f ! -name "*.gpg" ! -name "$(basename "$log_file")" -delete; then
    echo "Failed to clean up backup directory" | logger
fi

# Remove the password file after backup
rm -f "$password_file"

# Unmount the folder. It's not intended for this drive to be connected during working hours - protect from ransomware
# unmount with option -l /devsdx this can cause issues with the file system after unmounting
if ! umount -f /backup/bkmp; then
    echo "Failed to unmount backup folder" | logger
    
fi
