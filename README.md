# 8006-assign2

## Scripts

    nic-setup/firewall-nic-setup.sh - Sets up the NICs on the firewall host machine.
    nic-setup/host-nic-setup.sh - Sets up the NICs on the inner network host machine.
    nic-setup/nic-reset.sh - Resets all the NICs on the machine to use eno1.

    run.sh - Main script that sets up the firewall. Ensure that files in the settings folder are configured before running.
    wipe.sh - Compelely clears all firewall rules and sets all default policies to ACCEPT

## Settings

    settings/icmp_in_allow.txt - The ICMP type numbers to be allowed in.
    settings/icmp_out_allow.txt - The ICMP type numbers to be out in.
    settings/interface_external.txt - Name of external network inferface.
    settings/interface_internal.txt - Name of internal network interface.
    settings/internal_network_space.txt - The network space of the private network.
    settings/tcp_in_allow.txt - The TCP ports that will be open to incoming traffic.
    settings/tcp_out_allow.txt - The TCP ports that will be open to outgoing traffic.
    settings/tool.txt - Absolute path the the tool to use. If not iptables must be have './' prefix.
    settings/udp_in_allow.txt - The TCP ports that will be open to incoming traffic.
    settings/udp_out_allow.txt - The TCP ports that will be open to outgoing traffic.

Note: For setting files that contain lists, each entry must be on a new line with 1 empty line at the end of the file.
