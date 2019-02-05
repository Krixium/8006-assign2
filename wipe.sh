#!/bin/bash

iptables -F
iptables -F -t nat
iptables -X
