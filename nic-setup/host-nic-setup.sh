#!/bin/sh

ifconfig eno1 down
ifconfig enp3s2 192.168.10.2 up
route add default gw 192.168.10.1

echo "ensure /etc/resolv.conf are matching"