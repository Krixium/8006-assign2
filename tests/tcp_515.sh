#!/bin/bash
firewall_address=`cat firewall_address.txt`

hping3 -c 5 -p 515 -S $firewall_address

