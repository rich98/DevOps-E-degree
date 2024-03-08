This script is designed for creating system backups with options for compression, encryption, and customizable backup directories. The backup includes specified system directories, excluding certain ones, and provides options for compression and encryption to enhance security. The script uses rsync for efficient file synchronization and provides detailed logs for tracking the backup process.

# Prerequisites

The script should be run with root privileges (sudo or as root user).
Ensure the required tools (rsync, gpg, tar, logger) are installed.
Make sure the backup destination is properly mounted.
Usage
Run as Root:sudo backup2.5.sh

# Customization: Mount points
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

# Customization: Directories to include in the system backup

```bash
backup_dirs=(
    #"/etc"           # for system-wide configuration files.
    "/home"          # for user data and configuration.
    #"/var" 
    #"/root"          # for the root user's home directory.
    #"/usr/local/bin" 
    #"/srv" 
    #"/opt"           # Third-party apps
    
    # Add other directories you want to include
)

# Directories to exclude from the backup

exclude_dirs=(
    #"/var/lib/docker"
    "/tmp"           # Exclude temporary directories
    "/var/tmp"       # Exclude temporary directories
)

```

# Maximum file size to exclude (1 GB)

max_file_size=1G

Used to set the maxium size of the file that can be backed up - adjust as you like

# Other changes you can do.
Back folder mount point
Output type and location for password \ logfiles 
