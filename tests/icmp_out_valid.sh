#!/bin/bash
out_target=`cat out_target.txt`

declare -a allowed_types
readarray -t allowed_types < "../settings/icmp_out_allow.txt"

for t in ${allowed_types[*]}
do
    hping3 -c 5 --icmptype $t $out_target
done

