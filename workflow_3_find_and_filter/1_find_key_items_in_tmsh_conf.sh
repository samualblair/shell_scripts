#!/bin/sh

# Name: find_key_items_in_tmsh_conf.sh
# Author Michael Johnson 02-06-2025

# Expects script to be updated with source config files, for example:

# Expects script to be updated with source config files, for example:
# F5_BASE_CONFIG_FILES="hostname1_bigip_base.conf hostname2_bigip_base.conf"
# The script will itterate through each and output filters

F5_BASE_CONFIG_FILES="bigip_base.conf"
F5_CONFIG_FILES="bigip.conf"

for p in $F5_CONFIG_FILES
do
  echo "##########"
  echo Source File "$p"
  echo "##########"
  # LTM and General Section
  grep "ltm virtual-address " "$p" >> "$p"_va.txt
  grep "ltm virtual " "$p" >> "$p"_vs.txt
  grep "ltm pool " "$p" >> "$p"_pool.txt
  grep "ltm node " "$p" >> "$p"_node.txt
  grep "ltm monitor " "$p">> "$p"_monitor.txt
  grep "ltm rule " "$p">> "$p"_irule.txt
  grep "net route " "$p">> "$p"_net_route.txt
  # ASM Section
  grep "asm policy " "$p">> "$p"_asm_policy.txt
  grep "asm device-snyc " "$p">> "$p"_asm_sync.txt
  grep "asm predefined-policy " "$p">> "$p"_asm_predefined.txt
done

for p in $F5_BASE_CONFIG_FILES
do
  echo "##########"
  echo Source File "$p"
  echo "##########"
  grep "net self " "$p" >> "$p"_self.txt
  grep "net route-domain " "$p" >> "$p"_rd.txt
  grep "net vlan " "$p" >> "$p"_vlan.txt
  grep "sys management-route " "$p" >> "$p"_mgmt_route.txt
done
