#! /bin/sh

# Name: list_f5_merge_certificate_files.sh
# Author Michael Johnson 02-05-2024

# Simple script to take List of folder from unpacked F5 UCS, and print certificate files under the folders.
# Useful for quickly verifying that all files from seperate folders are included in a new merged folder.

# Usage: 
# Currently expecets ASIDE and BSIDE strings to be set in the script (list of folders)
# Currently expects the script will be executed in a 'parent' folder that holds all of the ASIDE and BSIDE folder under it

ASIDE="UCS_TEMP1 UCS_TEMP3 UCS_TEMPA UCS_TEMP_NEWA"
BSIDE="UCS_TEMP2 UCS_TEMP4 UCS_TEMPB UCS_TEMP_NEWB"

# Using 'ls' to show show 1 level (-1) of recursion (-R) in files - "ls -1 -R"

for p in $ASIDE $BSIDE
do
 ls -1 -R "$p/files_d/Common_d/certificate_d"
done

for p in $ASIDE $BSIDE
do
 ls -1 -R "$p/files_d/Common_d/certificate_signing_request_d"
done

for p in $ASIDE $BSIDE
do
 ls -1 -R "$p/files_d/Common_d/external_monitor_d"
done
