Backups2.3.sh Readme
1. Shebang and Bash Declaration:
#!/bin/bash 
•	The shebang #!/bin/bash at the beginning of the script specifies that the script should be interpreted and executed by the Bash shell.
2. Set Compression Flag and Encryption Password:
# Set the compression flag compression=true # Set the encryption password encryption_password="ee4KfInoequanGirpgsehVf" 
•	These lines set the compression flag to true, indicating that compression is enabled, and set the encryption_password to a specific value.
3. Mount Backup Folder:
# Mount the backup folder if ! mount -t ext4 /dev/sda1 /backup; then echo "Failed to mount backup folder" | logger exit 1 fi 
•	Attempts to mount the backup folder /backup from the device /dev/sda1 with the ext4 filesystem type.
•	If the mount operation fails, an error message is logged, and the script exits.
4. GPG Encryption Settings:
# GPG encryption settings with a password file password_file="/usr/local/bin/backup_script/password_file.txt" echo "$encryption_password" > "$password_file" chmod 600 "$password_file" 
•	Sets up GPG (GNU Privacy Guard) encryption by creating a password file and setting appropriate permissions.
5. Directories to Include and Exclude in the Backup:
backup_dirs=( "/etc" "/home" "/var" "/root" "/usr/local/bin" "/srv" "/opt" ) exclude_dirs=( "/tmp" "/var/tmp" ) 
•	Defines arrays backup_dirs and exclude_dirs containing directories to include and exclude in the system backup, respectively.
6. Maximum File Size and Destination Directory:
max_file_size=1G backup_dir="/backup" 
•	Sets the maximum file size to exclude (1 GB) and the destination directory for the system backup.
7. Date Format and Create Backup Folder:
date_format=$(date +"%Y%m%d_%H%M%S") backup_folder="$backup_dir/system_backup_${date_format}" mkdir -p "$backup_folder" 
•	Generates a date format and creates a backup folder with the current date and time.
8. Log Files:
log_file="$backup_folder/rsync_${date_format}.log" skipped_log_file="$backup_folder/skipped_files_${date_format}.log" 
•	Sets up log files for rsync output and skipped files.
9. GPG Commands:
gpg_command="gpg -c --cipher-algo AES256 --batch --passphrase-file $password_file" gpg_verify_command="gpg --decrypt --batch --passphrase-file $password_file" 
•	Defines GPG encryption and verification commands with specified options.
These parts of the script primarily involve setting up configurations, mounting the backup folder, defining directories for backup, setting encryption parameters, and preparing log files. The subsequent sections of the script perform the actual backup operations using rsync, handle logging, compression, encryption, hash calculation, cleanup, and unmounting of the backup folder.
10. Start Time Logging:
start_time=$(date +"%Y-%m-%d %H:%M:%S") echo "Backup started at $start_time" >> "$log_file" logger "Backup started at $start_time" # Send start time to syslog 
•	Records the start time of the backup in the log file.
•	Sends a message to the system log (syslog) using the logger command.
11. Rsync Command for Each Directory:
for dir in "${backup_dirs[@]}"; do if ! rsync -a --delete --exclude-from=<(printf '%s\n' "${exclude_dirs[@]}") --max-size=$max_file_size "$dir" "$backup_folder" --log-file="$log_file" --stats 2>&1; then echo "Failed to rsync $dir" | logger exit 1 fi done 
•	Uses the rsync command to copy files from specified directories to the backup folder.
•	Excludes certain directories and logs output to the rsync log file.
12. Filter and Log Skipped Files:
grep "skipping non-regular file" "$log_file" > "$skipped_log_file" 
•	Filters out lines containing "skipping non-regular file" from the rsync log and logs them to a separate file.
13. End Time Logging and File Statistics:
end_time=$(date +"%Y-%m-%d %H:%M:%S") echo "Backup ended at $end_time" >> "$log_file" num_files_backed_up=$(grep "Number of regular files transferred" "$log_file" | awk '{print $NF}') num_files_skipped=$(wc -l < "$skipped_log_file") echo "Number of files backed up: $num_files_backed_up" >> "$log_file" echo "Number of files skipped: $num_files_skipped" >> "$log_file" 
•	Records the end time of the backup in the log file.
•	Retrieves and logs the number of files backed up and skipped.
14. Logging and Copying Log Files:

echo "Backup completed successfully" >> "$log_file" logger "Backup completed successfully" # Send completion message to syslog logger "Number of files backed up: $num_files_backed_up" logger "Number of files skipped: $num_files_skipped" if ! cp "$hash_file" "/usr/local/bin/backup_scripts/"; then echo "Failed to copy hash file" | logger fi if ! cp "$log_file" "/usr/local/bin/backup_scripts/"; then echo "Failed to copy rsync log file" | logger fi 
•	Logs a success message in the log file and sends a completion message to syslog.
•	Logs the number of files backed up and skipped to syslog.
•	Copies the hash file and rsync log file to a specified directory for debugging.
15. Compression (if enabled):
if [ "$compression" = true ]; then if ! tar -czf "$backup_folder.tar.gz" -C "$backup_folder" .; then echo "Failed to compress backup folder" | logger exit 1 fi rm -rf "$backup_folder" backup_folder="$backup_folder.tar.gz" fi 
•	Checks if compression is enabled.
•	If yes, compresses the backup folder into a tarball using tar.
•	Removes the original backup folder and updates the variable with the new tarball name.
16. Encryption, Hash Calculation, and Cleanup:
if ! $gpg_command "$backup_folder"; then echo "Failed to encrypt backup folder" | logger fi hash_file="$backup_folder-backup_hash.sha256" if ! sha256sum "$backup_folder.gpg" > "$hash_file"; then echo "Failed to compute SHA-256 hash" | logger fi if ! find "$backup_dir" -type f ! -name "$(basename "$backup_folder.gpg")" ! -name "$(basename "$log_file")" -delete; then echo "Failed to clean up backup directory" | logger fi 
•	Encrypts the compressed backup folder using GPG.
•	Computes the SHA-256 hash of the encrypted backup folder and logs it.
•	Removes all files in the backup directory except for the tarball and the log file.
17. Remove Password File and Unmount Backup Folder:
rm -f "$password_file" if ! umount -f /backup; then echo "Failed to unmount backup folder" | logger fi 
•	Removes the password file after completing the backup.
•	Attempts to unmount the backup folder. If unsuccessful, logs an error.
This script orchestrates a systematic backup process, handling various aspects like logging, file operations, compression, encryption, and cleanup. It ensures detailed logging for monitoring the backup process and includes measures to protect against ransomware by unmounting the backup folder during working hours.
