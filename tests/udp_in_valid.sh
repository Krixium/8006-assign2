#!/bin/bash
firewall_address=`cat firewall_address.txt`
settings_file="../settings/udp_in_allow.txt"

declare -a allowed_ports
readarray -t allowed_ports < $settings_file

for port in ${allowed_ports[*]}
do
    hping3 -c 5 -p $port --udp $firewall_address
done

