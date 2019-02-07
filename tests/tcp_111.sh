#!/bin/bash
firewall_address=`cat firewall_address.txt`

hping3 -c 5 -i u1000 -S -p 111 $firewall_address

