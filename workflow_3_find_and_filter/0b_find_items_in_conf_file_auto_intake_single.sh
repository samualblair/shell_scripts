#!/bin/sh

# Name: find_items_in_conf_file_auto_intake_single.sh
# Author Michael Johnson 02-06-2025


# This script is expected to be run after 'find_key_items_in_tmsh_conf.sh' which would generate the files that need to be checked against.
# After running 'find_key_items_in_tmsh_conf.sh' but before running this script, you will need to manually remove unnesecary elements of text.
# Essentially remove the "ltm node /Common/" and " {" in "ltm node /Common/130.151.231.48 {" so you are left with just "130.151.231.48"

# Expects script to be run with a prefix paramater such as "host" which will be assumed to be in front of files
# If no input paramater is provided "host" will be assumed such as "host_bigip.conf"

# Example1 "/bin/sh find_items_in_conf_file_auto_intake_single.sh hostnameABC"
# This will parse files such as "hostnameABC_bigip.conf" and "hostnameABC_base.conf"
# Example2 "/bin/sh find_items_in_conf_file_auto_intake_single.sh hostname123"
# This will parse files such as "hostname123_bigip.conf" and "hostname123_base.conf"
# Example3 "/bin/sh find_items_in_conf_file_auto_intake_single.sh"
# This will parse files such as "host_bigip.conf" and "host_bigip_base.conf"


# Method 1 - use prompted for single device name (expects filename to be "host" for "host_bigip.conf" and "host_bigip_base.conf")

# Parse through bigip_base elements

echo ===========
echo Parsing "${1:-"host"}_bigip.conf"
echo ===========

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_va.txt"
  echo "##########" >> "${1:-"host"}_check_va.txt"
done < "${1:-"host"}_bigip.conf_va.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_vs.txt"
  echo "##########" >> "${1:-"host"}_check_vs.txt"
done < "${1:-"host"}_bigip.conf_vs.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_pool.txt"
  echo "##########" >> "${1:-"host"}_check_pool.txt"
done < "${1:-"host"}_bigip.conf_pool.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_node.txt"
  echo "##########" >> "${1:-"host"}_check_node.txt"
done < "${1:-"host"}_bigip.conf_node.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_monitor.txt"
  echo "##########" >> "${1:-"host"}_check_monitor.txt"
done < "${1:-"host"}_bigip.conf_monitor.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_irule.txt"
  echo "##########" >> "${1:-"host"}_check_irule.txt"
done < "${1:-"host"}_bigip.conf_irule.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip.conf" >> "${1:-"host"}_check_net_route.txt"
  echo "##########" >> "${1:-"host"}_check_net_route.txt"
done < "${1:-"host"}_bigip.conf_net_route.txt"

# Parse through bigip_base elements

echo ===========
echo Parsing "${1:-"host"}_bigip_base.conf"
echo ===========

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip_base.conf" >> "${1:-"host"}_check_self.txt"
  echo "##########" >> "${1:-"host"}_check_self.txt"
done < "${1:-"host"}_bigip_base.conf_self.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip_base.conf" >> "${1:-"host"}_check_rd.txt"
  echo "##########" >> "${1:-"host"}_check_rd.txt"
done < "${1:-"host"}_bigip_base.conf_rd.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip_base.conf" >> "${1:-"host"}_check_vlan.txt"
  echo "##########" >> "${1:-"host"}_check_vlan.txt"
done < "${1:-"host"}_bigip_base.conf_vlan.txt"

while IFS= read -r line; do
  grep "$line" "${1:-"host"}_bigip_base.conf" >> "${1:-"host"}_check_mgmt_route.txt"
  echo "##########" >> "${1:-"host"}_check_mgmt_route.txt"
done < "${1:-"host"}_bigip_base.conf_mgmt_route.txt"

