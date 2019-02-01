#!/bin/bash

ifconfig eno1 down
ifconfig enp3s2 192.168.10.2 up
route add default gw 192.168.10.1

NAME_IP=142.232.76.191
NAME_STR="nameserver $NAME_IP"
echo "ensure /etc/resolv.conf are matching"
grep -F "$NAME_STR" /etc/resolv.conf || echo "$NAME_STR" >> /etc/resolv.conf