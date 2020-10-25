#!/bin/bash

sudo sysctl -w net.ipv4.ip_forward=1
sudo ifconfig enp4s0 192.168.0.101 netmask 255.255.255.0 up
sudo iptables -t nat -A POSTROUTING -o wlp2s0 -j MASQUERADE
sudo iptables -I FORWARD -o wlp2s0 -s 192.168.0.0/16 -j ACCEPT
sudo iptables -I INPUT -s 192.168.0.0/16 -j ACCEPT
