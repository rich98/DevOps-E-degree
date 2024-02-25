#!/bin/bash

# Directory where the .gpg files are located
DIR="/backup/bkmp/"

# Find and delete .gpg files older than 5 days
find "$DIR" -name "*.gpg" -type f -mtime +5 -exec rm -f {} \;
