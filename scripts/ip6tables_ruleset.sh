#!/bin/sh

#Define a simple firewall that denies all incoming traffic but allows outgoing traffic
ip6tables -A INPUT -j REJECT
ip6tables -A FORWARD -j REJECT

printf "Finished applying IPv6 ruleset\n\n"
