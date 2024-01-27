Backups2.3.sh Readme

This Bash script performs a system backup by compressing, encrypting, and archiving specified directories. Let's break down the script step by step:

Set Configuration Variables:

compression: A flag indicating whether compression is enabled (set to true).
encryption_password: The password used for encrypting the backup.
Mount Backup Folder:

Mounts the backup folder (/backup) from the specified device (/dev/sda1). If unsuccessful, logs an error and exits.
GPG Encryption Settings:

Creates a GPG encryption password file (password_file.txt) and sets appropriate permissions.
Define Backup and Exclusion Directories:

backup_dirs: An array containing directories to be included in the backup.
exclude_dirs: An array containing directories to be excluded from the backup.
Set Maximum File Size and Destination Directory:

max_file_size: Maximum file size to exclude (set to 1 GB).
backup_dir: Destination directory for the system backup.
Create Backup Folder:

Creates a backup folder with a timestamp (system_backup_<timestamp>).
Set Log Files:

log_file: Log file to store rsync output.
skipped_log_file: Log file for skipped files during rsync.
Define GPG Commands:

gpg_command: GPG encryption command for encrypting the backup.
gpg_verify_command: GPG verification command.
Start Time Logging:

Logs the start time of the backup.
Rsync for Each Directory:

Uses rsync to copy and synchronize files from specified directories to the backup folder, excluding certain directories and limiting file size. Logs the rsync output and handles errors.
Filter Skipped Files and Log:

Filters out skipped files from the rsync log and logs them separately.
End Time Logging:

Logs the end time of the backup.
Log Number of Files Backed Up and Skipped:

Counts and logs the number of files backed up and skipped.
Copy Hash File and Rsync Log:

Copies the hash file and rsync log file to a specified location for debugging.
Compression (if enabled):

If compression is enabled, compresses the backup folder using tar and removes the original folder.
Encrypt Backup Folder:

Encrypts the system backup folder using GPG.
Compute SHA-256 Hash:

Computes the SHA-256 hash of the encrypted system backup folder.
Remove Unnecessary Files:

Removes all files in the backup directory except for the tarball and the log file.
Remove Password File:

Removes the password file used for encryption.
Unmount the Backup Folder:

Unmounts the backup folder. It's mentioned that the drive shouldn't be connected during working hours to protect from ransomware.
