#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a blocked_types
readarray -t blocked_types < "../settings/blocked_types.txt"

for t in ${blocked_types[*]}
do
    hping3 -c 5 -i u1000 --icmptype $t $firewall_address
done

