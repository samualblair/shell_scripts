#!/bin/sh

# Name: find_items_in_conf_file.sh
# Author Michael Johnson 02-05-2024

# Expects source file with list of items (such as virtual server names), one line each
# Runs against bigip.conf file, finding each element and printing matches to screen (or file if redirected with > or >>)
# Between each element a divider is shown ("##########")

# The $1 represents the first variable on the command line so you can run script with the filename after it, this will be the items to search for file
# The -test_1 represents the default variable, so if not run with any file at command line this file name will be used

# The $2 represents the second variable on the command line so you can run script with the filename after it, this will be the config file
# The -bigip.conf represents the default variable, so if not run with any file at command line this file name will be used

# Old method

#cat ${1:-test_1} | while IFS= read -r line
#do
#grep "$line" bigip.conf
#echo "##########"
#done

# Updated method, eliminates wasteful use of cat
while IFS= read -r line; do
  grep "$line" "${2:-bigip.conf}"
  echo "##########"
done < "${1:-test_1}"
