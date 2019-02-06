#!/bin/bash

internal_network_space=`cat settings/internal_network_space.txt`
tool=`cat settings/tool.txt`
apreroute="-A PREROUTING"
apostroute="-A POSTROUTING"
aforward="-A FORWARD"
ainput="-A INPUT"
nat="-t nat"
tcp="-p tcp -m tcp"
udp="-p udp -m udp"
icmp="-p icmp -m icmp"
external_interface=`cat settings/interface_external.txt`
internal_interface=`cat settings/interface_internal.txt`
out_to_in="-i $external_interface -o $internal_interface"
in_to_out="-o $external_interface -i $internal_interface"
firewall_ip_addr=`ifconfig $external_interface | grep 'inet ' | awk -F' ' '{ print \$2 }'`

echo "configuring firewall ..."

# wipe previous settings
$tool -F
$tool -X
$tool -t nat -F

$tool -P INPUT DROP
$tool -P OUTPUT DROP
$tool -P FORWARD DROP

# setting postrouting nat
$tool $nat $apostroute -o eno1 -j SNAT --to-source $firewall_ip_addr

# setting prerouting nat
$tool $nat $apreroute -d $firewall_ip_addr -j DNAT --to-destination 192.168.10.2

# drop packets from outside with ip of internal network
$tool $aforward $out_to_in -s $internal_network_space -j DROP

# drop wrong direction packet
$tool $aforward $tcp --syn --dport 1024:65535 -j DROP

# drop syn fin packets
$tool $aforward $tcp --tcp-flags SYN,FIN SYN,FIN -j DROP

# telnet is bad
$tool $aforward $tcp --sport 23 -j DROP
$tool $aforward $tcp --dport 23 -j DROP
$tool $aforward $udp --sport 23 -j DROP
$tool $aforward $udp --dport 23 -j DROP

# drop external traffic directed to ports 3278-32775, 137-139, TCP 111, TCP 515
$tool $aforward $out_to_in $tcp --dport 3278:32775 -j DROP
$tool $aforward $out_to_in $udp --dport 3278:32775 -j DROP
$tool $aforward $out_to_in $tcp --dport 137:139 -j DROP
$tool $aforward $out_to_in $udp --dport 137:139 -j DROP
$tool $aforward $out_to_in $tcp --dport 111 -j DROP
$tool $aforward $out_to_in $tcp --dport 515 -j DROP

# allow new and existing connections
$tool $aforward $out_to_in -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# open allowed ports
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
    $tool $aforward $out_to_in $tcp --sport $port -j ACCEPT
    $tool $aforward $out_to_in $tcp --dport $port -j ACCEPT
done

for port in ${tcp_out[*]}
do
    $tool $aforward $in_to_out $tcp --sport $port -j ACCEPT
    $tool $aforward $in_to_out $tcp --dport $port -j ACCEPT
done

for port in ${udp_in[*]}
do
    $tool $aforward $out_to_in $udp --sport $port -j ACCEPT
    $tool $aforward $out_to_in $udp --dport $port -j ACCEPT
done

for port in ${udp_out[*]}
do
    $tool $aforward $in_to_out $udp --sport $port -j ACCEPT
    $tool $aforward $in_to_out $udp --dport $port -j ACCEPT
done

for t in ${icmp_in[*]}
do
    $tool $aforward $out_to_in $icmp --icmp-type $t -j ACCEPT
done

for t in ${icmp_out[*]}
do
    $tool $aforward $in_to_out $icmp --icmp-type $t -j ACCEPT
done

# allow fragments
$tool $aforward -f -j ACCEPT

# set type of service
$tool $apreroute -t mangle -p tcp --sport ssh -j TOS --set-tos Minimize-Delay
$tool $apreroute -t mangle -p tcp --sport ftp -j TOS --set-tos Minimize-Delay
$tool $apreroute -t mangle -p tcp --sport ftp-data -j TOS --set-tos Maximize-Throughput
$tool $apreroute -t mangle -p tcp --dport ssh -j TOS --set-tos Minimize-Delay
$tool $apreroute -t mangle -p tcp --dport ftp -j TOS --set-tos Minimize-Delay
$tool $apreroute -t mangle -p tcp --dport ftp-data -j TOS --set-tos Maximize-Throughput

echo "firewall configured"
