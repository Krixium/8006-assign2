#!/bin/bash
firewall_address=`cat firewall_address.txt`

hping3 -c 5 -p 137 -S $firewall_address
hping3 -c 5 -p 138 -S $firewall_address
hping3 -c 5 -p 139 -S $firewall_address
