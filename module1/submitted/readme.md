Backups2.4.sh Readme

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

Copies the rsync log file to a specified location for debugging.
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

To manually perform a restore using the provided backup script, you would need to reverse the process by decrypting, decompressing (if applicable), and copying the data back to the original locations. Below are the steps for manual restore:

1. **Decrypt the Backup:**
   - Use the GPG command with the decryption option to decrypt the encrypted backup.
     ```bash
     gpg --decrypt --batch --passphrase-file /usr/local/bin/backup_script/password_file.txt "$backup_folder/system_backup_${date_format}.gpg" > "$backup_folder/system_backup_${date_format}.tar.gz"
     ```

2. **Decompress the Backup (if compression is enabled):**
   - If compression was enabled during the backup, use the tar command to decompress the backup.
     ```bash
     tar -xzf "$backup_folder/system_backup_${date_format}.tar.gz" -C "$backup_folder"
     ```

3. **Copy the Data Back to Original Locations:**
   - Copy the data back to their original locations using the rsync command or another appropriate method.
     ```bash
     rsync -a "$backup_folder/" /destination/directory/
     ```

4. **Perform Additional Steps (if applicable):**
   - Depending on the specific backup settings and requirements, you may need to perform additional steps such as setting file permissions, updating configuration files, etc.

5. **Clean Up (optional):**
   - Remove the decrypted and decompressed backup files if they are no longer needed.
     ```
   if ! find "$backup_dir" -type f ! -name "*.gpg" ! -name "$(basename "$log_file")" -delete; then
    echo "Failed to clean up backup directory" | logger
     ```

6. **MNount \ Unmount the Backup Folder (if applicable):**
Mount the backup folder
```if ! grep -qs '/backup ' /proc/mounts; then
    if ! mount -t ext4 /dev/sda1 /backup; then
        echo "Failed to mount backup folder" | logger
```

Unmount the folder. It's not intended for this drive to be connected during working hours - protect from ransomware
unmount with option -f /devsdx this can cause issues with the file system after unmounting
```if ! umount -f /backup; then
    echo "Failed to unmount backup folder" | logger
```

7. **Verify the Restore:**
   - Verify that the data has been successfully restored to their original locations.

It's important to note that manual restore processes may vary depending on the specific backup strategy and requirements. Always ensure that you thoroughly test the restore process in a safe environment before applying it to production data.


This is a bash script for performing system backups on a Linux machine. The script is designed to be run as root, ensuring it has the necessary permissions to access and copy system files. It includes features such as directory exclusion, file size filtering, optional compression, encryption using GPG, and logging for easy monitoring.

**Prerequisites**
The script must be run as the root user.
The backup folder should be mounted at /backup (adjustable).
GPG (GNU Privacy Guard) is required for encryption.

**clone repository**
Clone this repository to your local machine:

```git clone https://github.com/yourusername/backup-script.git
cd backup-script
```
Make the script executable:
```
chmod +x backup_script.sh
```
Run the script:
```
sudo ./backup_script.sh
```
**Crontab -e**

Replace X.X with version number
```
30 1 * * * /usr/local/bin/backup_script/backupX.X.sh
```
Every night at 01:30
