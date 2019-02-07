#!/bin/bash
firewall_address=`cat firewall_address.txt`

hping3 -c 5 -i u1000 -S -p 22 $firewall_address

