#!/bin/bash

echo "starting firewall setup ..."

echo "loading user settings ..."

# reading in setting files to array
declare -a icmp_in
declare -a icmp_out
declare -a tcp_in
declare -a tcp_out
declare -a udp_in
declare -a udp_out

readarray -t icmp_in < settings/icmp_in_allow.txt
readarray -t icmp_out < settings/icmp_in_allow.txt
readarray -t tcp_in < settings/tcp_in_allow.txt
readarray -t tcp_out < settings/tcp_out_allow.txt
readarray -t udp_in < settings/udp_in_allow.txt
readarray -t udp_out < settings/udp_out_allow.txt

echo "allowed icmp in:"
for type in ${icmp_in[*]}
do
    echo $type
done

echo "allowed icmp out:"
for type in ${icmp_out[*]}
do
    echo $type
done

echo "allowed tcp in:"
for port in ${tcp_in[*]}
do
    echo $port
done

echo "allowed tcp out:"
for port in ${tcp_out[*]}
do
    echo $port
done

echo "allowed udp in:"
for port in ${udp_in[*]}
do
    echo $port
done

echo "allowed udp out:"
for port in ${udp_out[*]}
do
    echo $port
done