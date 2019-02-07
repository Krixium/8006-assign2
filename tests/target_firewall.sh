#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a allow_tcp
declare -a allow_udp

readarray -t allow_tcp < "../settings/tcp_in_allow.txt"
readarray -t allow_udp < "../settings/udp_in_allow.txt"

for $port in ${allow_tcp[*]}
do
    hping3 -c 5 -S -p $port $firewall_address
done

for $port in ${allow_udp[*]}
do
    hping3 -c 5 --udp -p $port $firewall_address
done

