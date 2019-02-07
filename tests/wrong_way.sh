#!/bin/bash
firewall_address=`cat firewall_address.txt`

for port in {1024..65535..10000}
do
    hping3 -c 5 -s 80 -p $port -S $firewall_address
done

