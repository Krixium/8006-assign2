#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a blocked_ports
readarray -t blocked_ports < "../settings/blocked_ports.txt"

for port in ${blocked_ports[*]}
do
    hping3 -c 5 -S -p $port -i u1000 $firewall_address
    hping3 -c 5 --udp -p -i u1000 $port $firewall_address
done

