#!/bin/sh

#Define a simple firewall that denies all incoming traffic but allows outgoing traffic
sudo ip6tables -A INPUT -j REJECT
sudo ip6tables -A FORWARD -j REJECT
