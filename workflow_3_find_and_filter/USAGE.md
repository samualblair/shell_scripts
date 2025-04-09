# Find instance of Items from files (find_items_in_conf_file.sh)

# Script Explaination
This script will help confirm usage of items in a bigip.conf file

The $1 represents the first variable on the command line so you can run script with the filename after it, this will be the items to search for file.

The $2 represents the second variable on the command line so you can run script with the filename after it, this will be the config file.

The '-test_1' represents the default variable for input file, so if not run with any file at command line this file name will be used. Normally expect this to be called out. The '-bigip.conf' represents the default variable for config file (second input) and optionally can be specified.

Example usage:
```bash
/bin/bash sort_items_file.sh only_pools >> first_pass_check_pools.txt
```

Script Body:
```bash
while IFS= read -r line; do
  grep "$line" "${2:-bigip.conf}"
  echo "##########"
done < "${1:-test_1}"

```

## Detailed Example usage
Source File of 'pools' which is name of pools, named "only_pools.txt"

Source file contents:
```txt
pool_name1 
name_of_pool2
a_third_name

```

Script executed:
```bash
/bin/bash sort_items_file.sh only_pools.txt >> first_pass_check_pools.txt
```

A File in same folder as script will be checked (bigip.conf) for matches.

Example bigip.conf:
```
ltm virtual1 {
   address 4.5.6.7
   pool name_of_pool4
   }
ltm virtual3 {
   address 4.5.6.7
   pool pool_name1
   }
ltm pool name_of_pool2 {
 member xyz.example
 }
ltm pool pool_name1 {
 member abc.example
 }

```

A file will be created called "first_pass_check_pools.txt" with output, example:
```
    pool pool_name1
 ltm pool pool_name1 {
##########
 ltm pool name_of_pool2 {
##########

```

## Authors
Michael Johnson ([@samualblair](https://github.com/samualblair))

## Versioning
[![CalVer](https://img.shields.io/static/v1?label=CalVer&message=YY.0M.0D)](https://calver.org/)

* 2025.04.08 - General release
