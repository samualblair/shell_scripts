#!/bin/sh

# Name: find_items_in_conf_file_auto_intake_list
# Author Michael Johnson 02-06-2025

# This script is expected to be run after 'find_key_items_in_tmsh_conf.sh' which would generate the files that need to be checked against.
# After running 'find_key_items_in_tmsh_conf.sh' but before running this script, you will need to manually remove unnesecary elements of text.
# Essentially remove the "ltm node /Common/" and " {" in "ltm node /Common/130.151.231.48 {" so you are left with just "130.151.231.48"

# Expects script to be updated with source config files, for example:
# F5_BASE_CONFIG_FILES="hostname1_bigip_base.conf hostname2_bigip_base.conf"
# The script will itterate through each and output filters

F5_BASE_CONFIG_FILES="bigip_base.conf host2_bigip_base.conf host_bigip_base.conf"
F5_CONFIG_FILES="bigip.conf host2_bigip.conf host_bigip.conf"

# Method 2 - use list of files

# Ensure bigip.conf files are in proper list ($F5_CONFIG_FILES)

for f5_conf_file in $F5_CONFIG_FILES
do

  echo "Parsing ${f5_conf_file}"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_va.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_va.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_va.txt"
    echo "##########" >> "${f5_conf_file}_check_va.txt"
  done < "${f5_conf_file}_va.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_va.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_vs.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_vs.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_vs.txt"
    echo "##########" >> "${f5_conf_file}_check_vs.txt"
  done < "${f5_conf_file}_vs.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_vs.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_pool.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_pool.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_pool.txt"
    echo "##########" >> "${f5_conf_file}_check_pool.txt"
  done < "${f5_conf_file}_pool.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_pool.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_node.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_node.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_node.txt"
    echo "##########" >> "${f5_conf_file}_check_node.txt"
  done < "${f5_conf_file}_node.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_node.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_monitor.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_monitor.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_monitor.txt"
    echo "##########" >> "${f5_conf_file}_check_monitor.txt"
  done < "${f5_conf_file}_monitor.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_monitor.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_irule.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_irule.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_irule.txt"
    echo "##########" >> "${f5_conf_file}_check_irule.txt"
  done < "${f5_conf_file}_irule.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_irule.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_net_route.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_net_route.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_net_route.txt"
    echo "##########" >> "${f5_conf_file}_check_net_route.txt"
  done < "${f5_conf_file}_net_route.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_net_route.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_asm_policy.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_asm_policy.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_asm_policy.txt"
    echo "##########" >> "${f5_conf_file}_check_asm_policy.txt"
  done < "${f5_conf_file}_asm_policy.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_asm_policy.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_asm_sync.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_asm_sync.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_asm_sync.txt"
    echo "##########" >> "${f5_conf_file}_check_asm_sync.txt"
  done < "${f5_conf_file}_asm_sync.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_asm_sync.txt"

  echo "###### PARSING START ######" >> "${f5_conf_file}_check_asm_predefined.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_conf_file}_check_asm_predefined.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_conf_file" >> "${f5_conf_file}_check_asm_predefined.txt"
    echo "##########" >> "${f5_conf_file}_check_asm_predefined.txt"
  done < "${f5_conf_file}_asm_predefined.txt"
  echo "###### PARSING END   ######" >> "${f5_conf_file}_check_asm_predefined.txt"

done

# Ensure bigip_base.conf files are in proper list ($F5_BASE_CONFIG_FILES)

for f5_base_conf_file in $F5_BASE_CONFIG_FILES
do

  echo "Parsing ${f5_base_conf_file}"

  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_self.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_self.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_self.txt"
    echo "##########" >> "${f5_base_conf_file}_check_self.txt"
  done < "${f5_base_conf_file}_self.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_self.txt"

  # Detailed Net Self IP Configuration useful
  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_self_details.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_self_details.txt"
  while IFS= read -r line; do
    grep -A 10 "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_self_details.txt"
    echo "##########" >> "${f5_base_conf_file}_check_self_details.txt"
  done < "${f5_base_conf_file}_self.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_self_details.txt"

  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_rd.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_rd.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_rd.txt"
    echo "##########" >> "${f5_base_conf_file}_check_rd.txt"
  done < "${f5_base_conf_file}_rd.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_rd.txt"

  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_vlan.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_vlan.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_vlan.txt"
    echo "##########" >> "${f5_base_conf_file}_check_vlan.txt"
  done < "${f5_base_conf_file}_vlan.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_vlan.txt"

  # Detailed Net VLAN Configuration
  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_vlan_details.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_vlan_details.txt"
  while IFS= read -r line; do
    grep -A 10 "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_vlan_details.txt"
    echo "##########" >> "${f5_base_conf_file}_check_vlan_details.txt"
  done < "${f5_base_conf_file}_vlan.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_vlan_details.txt"

  echo "###### PARSING START ######" >> "${f5_base_conf_file}_check_mgmt_route.txt"
  echo "###### PARSING DATE: $(DATE)" >> "${f5_base_conf_file}_check_mgmt_route.txt"
  while IFS= read -r line; do
    grep "$line" < "$f5_base_conf_file" >> "${f5_base_conf_file}_check_mgmt_route.txt"
    echo "##########" >> "${f5_base_conf_file}_check_mgmt_route.txt"
  done < "${f5_base_conf_file}_mgmt_route.txt"
  echo "###### PARSING END   ######" >> "${f5_base_conf_file}_check_mgmt_route.txt"

done
