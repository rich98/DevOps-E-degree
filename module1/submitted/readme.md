This script is designed for creating system backups with options for compression, encryption, and customizable backup directories. The backup includes specified system directories, excluding certain ones, and provides options for compression and encryption to enhance security. The script uses rsync for efficient file synchronization and provides detailed logs for tracking the backup process.

# Prerequisites

The script should be run with root privileges (sudo or as root user).
Ensure the required tools (rsync, gpg, tar, logger) are installed.
Make sure the backup destination is properly mounted.
Usage
Run as Root:sudo backup2.5.sh

# Customization:
Make sure you use the fisk uuid and not the sda or sdb name as these can swap around on reboot. you must update
this line as per your configuartion.
Mounting by ID is a reliable way to ensure that the correct device is mounted, even if the device names (/dev/sd*) change. This is particularly useful in systems where the device names can change between reboots.

## Mount a partition using its UUID (Universally Unique Identifier):

First, you need to find the UUID of the partition. You can do this by running the following command in the terminal:

sudo blkid

This command will display the UUIDs for all of your partitions.

Once you have the UUID, you can use it to mount the partition. Here’s an example:
sudo mount UUID=your-uuid-here /mount/point

Replace your-uuid-here with the UUID you got from the blkid command, and /mount/point with the directory where you want to mount the partition1.

Remember to replace your-uuid-here and /mount/point with the actual UUID of your partition and the actual directory where you want to mount it.

You can also use the UUID in the /etc/fstab file to automatically mount partitions at boot. Here’s an example of an /etc/fstab entry:

UUID=your-uuid-here /mount/point ext4 defaults 0 0
Adjust the backup_dirs array to include/exclude specific directories.
Modify the exclude_dirs array to exclude specific directories.
Set the compression flag to true or false as per your preference.
Change the encryption_password to a strong passphrase.

# Restore Instructions:

Decrypt the backup file using the command:
'''
gpg --decrypt --output decrypted_backup_folder.tar.gz --batch --passphrase-file <path_to_password_file> <encrypted_backup_folder.gpg>
Extract the decrypted backup file:

tar -xzf decrypted_backup_folder.tar.gz

# Logs:

Detailed logs are available in the backup folder (rsync_<timestamp>.log).
Skipped files are logged in skipped_files_<timestamp>.log.
Cleanup:

The script automatically cleans up the backup directory, leaving only .gpg files and log files.
Unmounting Backup Folder:

The script unmounts the backup folder after completion. Ensure the drive is not connected during working hours for security.
Important Notes
Protect the encryption password and the backup files; they are critical for restoring data.
Regularly review and test the backup and restore process to ensure reliability.
Disclaimer
This script is provided as-is without any warranties. Use it at your own risk and ensure its compatibility with your system and backup requirements.

Author: Rich98
Version: 2.4
