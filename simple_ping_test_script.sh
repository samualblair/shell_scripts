#! /bin/sh

# Name: simple_ping_test_script.sh
# Author Michael Johnson 02-05-2024

# This script can be customized and be used for quickly running tests of connectivity
# Example use case is testing on F5 Device to other F5 Devices, to ensure network connectivity across many interfaces

echo example1.domain.local SELF-IP

#Test HA
ping -c 2 -i .2 192.168.252.3 | grep -e statistics -e received
ping -c 2 -i .2 192.168.253.3 | grep -e statistics -e received

#Test Data (VIPs and Nodes)
ping -c 2 -i .2 10.10.0.7 | grep -e statistics -e received
ping -c 2 -i .2 11.11.0.7 | grep -e statistics -e received

echo example2.domain.local SELF-IP

#Test HA
ping -c 2 -i .2 192.168.252.4 | grep -e statistics -e received
ping -c 2 -i .2 192.168.253.4 | grep -e statistics -e received

#Test Data (VIPs and Nodes)
ping -c 2 -i .2 10.10.0.8 | grep -e statistics -e received
ping -c 2 -i .2 11.11.0.8 | grep -e statistics -e received

echo FLOATING

#Test Data (VIPs and Nodes)
ping -c 2 -i .2 10.10.0.11| grep -e statistics -e received
ping -c 2 -i .2 10.10.0.12| grep -e statistics -e received
ping -c 2 -i .2 10.10.0.13| grep -e statistics -e received
ping -c 2 -i .2 11.11.0.11| grep -e statistics -e received
ping -c 2 -i .2 11.11.0.12| grep -e statistics -e received
