#!/bin/bash

# get ip main network card
ip_addr=`ifconfig eno1 | grep 'inet ' | awk -F' ' '{ print \$2 }'`

ifconfig enp3s2 192.168.10.1 up
echo "1" > /proc/sys/net/ipv4/ip_forward
route add -net 192.168.0.0 netmask 255.255.255.0 gw $ip_addr
route add -net 192.168.10.0/24 gw 192.168.10.1

iptables -F
iptables -X
iptables -A FORWARD -i eno1 -o enp3s2 -j ACCEPT
iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE

echo "ensure /etc/resolv.conf are matching"