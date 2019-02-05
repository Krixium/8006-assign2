#!/bin/bash

# get ip main network card
ip_addr=`ifconfig eno1 | grep 'inet ' | awk -F' ' '{ print \$2 }'`

ifconfig enp3s2 192.168.10.1 up
echo "1" > /proc/sys/net/ipv4/ip_forward
route add -net 192.168.0.0 netmask 255.255.255.0 gw $ip_addr
route add -net 192.168.10.0/24 gw 192.168.10.1
