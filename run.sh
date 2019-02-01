#!/bin/bash

tool="iptables"
tcp="-p tcp -m tcp"
udp="-p udp -m udp"
eno_to_enp="-i eno1 -o enp3s2"

echo "starting firewall setup ..."

echo "loading user settings ..."

# generic setup
$tool -F
$tool -X

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

for port in ${tcp_in[*]}
do
    $tool -A FORWARD $eno_to_enp $tcp --sport $port -j ACCEPT
    $tool -A FORWARD $eno_to_enp $tcp --dport $port -j ACCEPT
done

for port in ${tcp_out[*]}
do
    $tool -t nat -A POSTROUTING -o eno1 $tcp --sport $port -j MASQUERADE
    $tool -t nat -A POSTROUTING -o eno1 $tcp --dport $port -j MASQUERADE
done

for port in ${udp_in[*]}
do
    $tool -A FORWARD $eno_to_enp $udp --sport $port -j ACCEPT
    $tool -A FORWARD $eno_to_enp $udp --dport $port -j ACCEPT
done

for port in ${udp_out[*]}
do
    $tool -t nat -A POSTROUTING -o eno1 $udp --sport $port -j MASQUERADE
    $tool -t nat -A POSTROUTING -o eno1 $udp --dport $port -j MASQUERADE
done