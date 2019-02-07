#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a allowed_types
readarray -t allowed_types < "../settings/icmp_in_allow.txt"

for t in ${allowed_types[*]}
do
    hping3 -c 5 -i u1000 --icmptype $t $firewall_address
done

