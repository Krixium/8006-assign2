#!/bin/bash

iptables -F
iptables -F -t nat
iptables -F -t mangle
iptables -X

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
