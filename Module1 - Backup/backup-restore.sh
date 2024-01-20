#!/bin/bash

# Set the compression flag
compression=true

# Set the encryption password 
encryption_password="my_password"

# VMware VMDK details
vmdk_path="/path/to/your.vmdk"
mount_point="/path/to/mount_point"

# GPG encryption settings with a password file
password_file="/path/to/password_file.txt"
echo "$encryption_password" > "$password_file"
chmod 600 "$password_file"

# Mount the VMDK
vmware-mount -p "$password_file" -k "$encryption_password" -m "$vmdk_path" "$mount_point"

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
)

# Maximum file size to exclude (1 GB)
max_file_size=1G

# Destination directory for the system backup
backup_dir="/path/to/system_backup"

# Log file to store rsync output
log_file="/path/to/backup.log"

gpg_command="gpg -c --cipher-algo AES256 --batch --passphrase-file $password_file"  # Adjust encryption options as needed
gpg_verify_command="gpg --decrypt --batch --passphrase-file $password_file"  # Verification command

# Date format for backup folder
date_format=$(date +"%Y%m%d_%H%M%S")

# Create backup folder with date and time
backup_folder="$backup_dir/system_backup_${date_format}"
mkdir -p "$backup_folder"

# Rsync command for each directory, excluding directories
for dir in "${backup_dirs[@]}"; do
    find "$dir" -type f -size -$max_file_size -print0 | rsync -a --delete --files-from=- --from0 --exclude=${exclude_dirs[*]} "$dir" "$backup_folder" >> "$log_file" 2>&1
done

# Logging
echo "$(date +"%Y-%m-%d %H:%M:%S") Backup completed successfully" >> "$log_file"

# Compression if enabled
if [ "$compression" = true ]; then
    gzip_command="gzip -9"  # Adjust compression level as needed
    $gzip_command "$backup_folder"/*
fi

# Encrypt the system backup folder with the specified password
$gpg_command "$backup_folder"

# Compute SHA-256 hash of the encrypted system backup folder
sha256sum "$backup_folder.gpg" > "$backup_folder/backup_hash.sha256"

# Unmount the VMDK after backup
vmware-mount -p "$password_file" -k "$encryption_password" -U "$vmdk_path"

# Remove the password file after backup
rm -f "$password_file"
