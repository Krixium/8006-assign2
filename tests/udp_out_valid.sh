#!/bin/bash
out_target=`cat out_target.txt`

declare -a allowed_ports
readarray -t allowed_ports < "../settings/udp_out_allow.txt"

for port in ${allowed_ports[*]}
do
    hping3 -c 5 --udp -p $port $out_target
done

