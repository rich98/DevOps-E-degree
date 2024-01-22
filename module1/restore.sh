#!/bin/bash

# Set the decryption password
decryption_password="e4KfIn!oequa>nGirpgseh(Vf%)~|E4*ezq^F'/liG5ko9^_{j"

# GPG decryption settings with a password file
password_file="/usr/local/bin/restore_script/password_file.txt"
echo "$decryption_password" > "$password_file"
chmod 600 "$password_file"

# GPG command for decryption
gpg_command="gpg --decrypt --batch --passphrase-file $password_file"

# List of backup files
backup_files=(
    "/backup/system_backup_*.tar.gz.gpg"
)

# Decrypt and extract each backup file
for file in "${backup_files[@]}"; do
    # Decrypt the backup file
    decrypted_file="${file%.gpg}"
    $gpg_command -o "$decrypted_file" "$file"

    # Extract the backup file to the original directory by default
    # If a different destination is specified, restore to that location
    if [ -z "$1" ]; then
        tar -xzf "$decrypted_file" -C "/"
    else
        tar -xzf "$decrypted_file" -C "$1"
    fi

    # Remove the decrypted file
    rm -f "$decrypted_file"
done

# Remove the password file after restore
rm -f "$password_file"
