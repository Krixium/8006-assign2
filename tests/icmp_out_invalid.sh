#!/bin/bash
out_target=`cat out_target.txt`

declare -a blocked_types
readarray -t blocked_types < "../settings/blocked_types.txt"

for t in ${blocked_types[*]}
do
    hping3 -c 5 --icmptype $t $out_target
done
