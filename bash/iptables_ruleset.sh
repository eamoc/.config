#!/bin/sh
# Allow all loopback (lo0) traffic and drop all traffic to 127/8
# that doesn't use lo0
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -d 127.0.0.0/8 ! -i lo -j REJECT --reject-with icmp-port-unreachable

# Allow established sessions to receive traffic
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ICMP pings
#sudo iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Allow SSH remote
#sudo iptables -I INPUT -p tcp --dport 22 -j ACCEPT

# Reject all other inbound connections
sudo iptables -A INPUT -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A FORWARD -j REJECT --reject-with icmp-port-unreachable
