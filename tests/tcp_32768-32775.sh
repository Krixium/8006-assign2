#!/bin/bash
firewall_address=`cat firewall_address.txt`

for port in {32768..32775}
do
    hping3 -c 5 -i u1000 -p $port -S $firewall_address
done


