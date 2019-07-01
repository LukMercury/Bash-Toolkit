#!/bin/bash
# run with root crontab

ping -c1 8.8.8.8 &> /dev/null

if [ $? -ne 0 ]; then
    sudo systemctl restart NetworkManager.service
fi
