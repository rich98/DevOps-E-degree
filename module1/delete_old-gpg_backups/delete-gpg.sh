#!/bin/bash

# Directory where the .gpg files are located
DIR="/path/to/your/directory"

# Find and delete .gpg files older than 5 days
find "$DIR" -name "*.gpg" -type f -mtime +5 -exec rm -f {} \;
