#!/bin/bash

PC_IP=192.168.0.101
WIRED_INTERFACE=enp4s0
WIRELESS_INTERFACE=wlp2s0

sudo sysctl -w net.ipv4.ip_forward=1
sudo ifconfig $WIRED_INTERFACE $PC_IP netmask 255.255.255.0 up
sudo iptables -t nat -A POSTROUTING -o $WIRELESS_INTERFACE -j MASQUERADE
sudo iptables -I FORWARD -o $WIRELESS_INTERFACE -s 192.168.0.0/16 -j ACCEPT
sudo iptables -I INPUT -s 192.168.0.0/16 -j ACCEPT
