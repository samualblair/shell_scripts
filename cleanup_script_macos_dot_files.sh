#!/bin/sh

# Name: find_items_in_conf_file.sh
# Author Michael Johnson 02-08-2025

# Script executes in current folder and parses recursivly down folders
# Any file starting with name "._" is removed, these are the names of attribute files that MacOS creates when moving to a filesystem that does not support native extended scurity attributes.

# May also just conisder bash/sh with one command: 
# find . -name "\._*" -delete

FOUNDFILES=$(find . -name "\._*")

for file in $FOUNDFILES
do
  echo "Found file and Removing: $file"
  rm "$file"
done
