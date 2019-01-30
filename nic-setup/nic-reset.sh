#!/bin/bash

ifconfig enp3s2 down
ifconfig eno1 up

echo "0" > /proc/sys/net/ipv4/ip_forward

iptables -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
