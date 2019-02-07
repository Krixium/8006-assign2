#!/bin/bash
firewall_address=`cat firewall_address.txt`

declare -a tcp_ports
declare -a udp_ports

readarray -t tcp_ports < "../settings/tcp_in_allow.txt"
readarray -t udp_ports < "../settings/udp_in_allow.txt"

for port in ${tcp_ports[*]}
do
    hping3 -c 5 -i u1000 -a 192.168.10.100 -s 7575 -p $port -S $firewall_address
done

for port in ${udp_ports[*]}
do
    hping3 -c 5 -i u1000 -a 192.168.10.100 -s 7575 -p $port --udp $firewall_address
done
