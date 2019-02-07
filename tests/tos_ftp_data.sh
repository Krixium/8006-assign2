#!/bin/bash
firewall_address=`cat firewall_address.txt`

hping3 -c 5 -S -p 20 $firewall_address

