#!/bin/bash

# Set the compression flag
compression=true

# Set the encryption password 
encryption_password="blackswan"

# Mount the backup folder
mount -t ext4 /dev/sda1 /backup 

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
    "/var/lib/docker"
    "/tmp"           # Exclude temporary directories
    "/var/tmp"       # Exclude temporary directories
)

# Maximum file size to exclude (1 GB)
max_file_size=1G

# Destination directory for the system backup. Its not intended for this drive to be connected during working hours - protect fron ransomeware
backup_dir="/backup"

# Log file to store rsync output
log_file="/usr/local/bin/backup_script/rsync.log"

gpg_command="gpg -c --cipher-algo AES256 --batch --passphrase-file $password_file"  # Adjust encryption options as needed
gpg_verify_command="gpg --decrypt --batch --passphrase-file $password_file"  # Verification command

# Date format for backup folder
date_format=$(date +"%Y%m%d_%H%M%S")

# Create backup folder with date and time
backup_folder="$backup_dir/system_backup_${date_format}"
mkdir -p "$backup_folder"

# Rsync command for each directory, excluding directories
for dir in "${backup_dirs[@]}"; do
    rsync -a --delete --exclude-from=<(printf '%s\n' "${exclude_dirs[@]}") --max-size=$max_file_size "$dir" "$backup_folder" >> "$log_file" 2>&1
done

# Logging
echo "$(date +"%Y-%m-%d %H:%M:%S") Backup completed successfully" >> "$log_file"

# Compression if enabled
if [ "$compression" = true ]; then
    tar -czf "$backup_folder.tar.gz" -C "$backup_folder" .
    rm -rf "$backup_folder"
    backup_folder="$backup_folder.tar.gz"
fi

# Encrypt the system backup folder with the specified password
$gpg_command "$backup_folder"

# Compute SHA-256 hash of the encrypted system backup folder
hash_file="/usr/local/bin/backup_script/$(basename "$backup_folder")-backup_hash.sha256"
sha256sum "$backup_folder.gpg" > "$hash_file"

# Remove all files in the backup directory except for the tarball and the log file
find "$backup_dir" -type f ! -name "$(basename "$backup_folder.gpg")" ! -name "$(basename "$log_file")" -delete

# Remove the password file after backup
rm -f "$password_file"

#Umount the folder Its not intended for this drive to be connected during working hours - protect fron ransomeware
umount -l /dev/sda1
umount -f /backup

