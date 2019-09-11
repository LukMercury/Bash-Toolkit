#!/bin/bash

MOUNT_POINT=/mnt/ramdisk
if [ ! -z "$2" ]; then
    MOUNT_POINT="$2"
fi

# Maximum ramdisk size cannot exceed half of free memory
MAX_SIZE=$(($(free | head -2 | tail -1 | tr -s [:space:] | cut -d' ' -f7)/2000))
DEFAULT_SIZE=1000 # MB

checkStatus()
{
    if mountpoint -q $MOUNT_POINT ; then
        df -h $MOUNT_POINT
    else
        echo "Ramdisk not mounted"
    fi
}

if [ "$1" == "u" ] || [ "$1" == "-u" ] || [ "$1" == "umount" ]; then
    sudo umount $MOUNT_POINT && echo "Ramdisk unmounted"
    exit 0
elif [ "$1" == "s" ] || [ "$1" == "-s" ] || [ "$1" == "status" ]; then
    checkStatus
    exit 0
fi

if [ ! -d "$MOUNT_POINT" ]; then
    read -N 1000000 -t 0.01 # Clear input 
    echo -n "Mount point $MOUNT_POINT doesn't exist, create it? (y/N): "
    read INPUT
    if [ "$INPUT" == "y" ] || [ "$INPUT" == "Y" ]; then
        mkdir -p "$MOUNT_POINT"
    else
        echo "Mountpoint for ramdisk not created"
        exit 1
    fi
fi

if [ -z "$1" ]; then
    SIZE=$DEFAULT_SIZE
elif [[ "$1" =~ ^[0-9]+$ ]]; then
    SIZE=$1
else
    echo "Bad argument: $1"
    exit 2
fi

if [ $SIZE -lt $MAX_SIZE ]; then
    sudo mount -t tmpfs -o size="$SIZE"M tmpfs $MOUNT_POINT
    echo "$SIZE MB ramdisk created at $MOUNT_POINT"
    exit 0
else
    echo "Ramdisk size cannot exceed half your free memory"
    exit 1
fi

