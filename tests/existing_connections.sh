#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a allowed_ports
readarray -t allowed_ports < "../settings/tcp_in_allow.txt"

for port in ${allowed_ports[*]}
do
    hping3 -c 5 -SA -p $port $firewall_address
done

