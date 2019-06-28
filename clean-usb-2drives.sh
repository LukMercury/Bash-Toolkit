#!/bin/bash

# Cleans usb drive
# Usage: clean-usb /dev/sdX

if [ -z "$1" ]; then
    echo "Missing argument. Please enter USB device (ex. /dev/sdb)."
    echo "Exiting..."
    exit 4
fi

if [ "$1" == "/dev/sdb" ]; then
    echo "Can't clean your main drive. Exiting."
    exit 3
fi

if [ "$1" == "/dev/sda" ]; then
    echo "Can't clean your home drive. Exiting."
    exit 3
fi

df -h "$1" &> /dev/null 
if [ $? != 0 ]; then
    echo "No device at $1. Is your USB drive plugged in?"
    exit 2
fi

df -h "$1"? | tail -n+2

echo -n "Clean drive? (y/N): "

read INPUT
if [ "$INPUT" == "y" ] || [ "$INPUT" == "Y" ]; then
    sudo umount "$1"? 2> /dev/null

    echo "Cleaning USB..."
    sudo wipefs -a "$1" > /dev/null
    sudo parted "$1" mktable msdos &> /dev/null
    sudo parted "$1" mkpart primary 0% 100% &> /dev/null
    sudo mkntfs -f "$1"1 > /dev/null

    if [ $? -eq 0 ]; then
        echo "Done. USB ready to use."
    else
        echo "Something went wrong."
        exit 1
    fi
else
    echo "Nothing to do. Exiting."
fi

