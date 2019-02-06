#!/bin/bash

ifconfig enp3s2 down
ifconfig eno1 up

echo "0" > /proc/sys/net/ipv4/ip_forward

./../wipe.sh