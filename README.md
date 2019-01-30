# 8006-assign2

## Scripts

    nic-setup/firewall-nic-setup.sh - Sets up the NICs on the firewall host machine.
    nic-setup/host-nic-setup.sh - Sets up the NICs on the inner network host machine.
    nic-setup/nic-reset.sh - Resets all the NICs on the machine to use eno1.

    run.sh - Main script that sets up the firewall. Ensure that files in the settings folder are configured before running.

## Settings

    settings/icmp_in_allow.txt - The ICMP type numbers to be allowed in.
    settings/icmp_out_allow.txt - The ICMP type numbers to be out in.
    settings/tcp_in_allow.txt - The TCP ports that will be open to incoming traffic.
    settings/tcp_out_allow.txt - The TCP ports that will be open to outgoing traffic.
    settings/udp_in_allow.txt - The TCP ports that will be open to incoming traffic.
    settings/udp_out_allow.txt - The TCP ports that will be open to outgoing traffic.

Note: All entries into setting files should be one number per line and the very last line should be empty.

``` Text
E.g. Inside settings/tcp_in_allow.txt:
22
53
67
68
80
443

```