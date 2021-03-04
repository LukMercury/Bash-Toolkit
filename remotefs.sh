#!/bin/bash
USAGE='Usage: remotefs.sh [user@host:/path/to/folder] <mountpoint>'

if [ -z $1 ]; then
    echo $USAGE
    exit 1
fi
HOSTFS="$1"

if [ -z $2 ]; then
    MOUNTPOINT=$HOME/mnt_remotefs
else
    MOUNTPOINT="$2"
fi
mkdir -p "$MOUNTPOINT"

sshfs -o IdentityFile=$HOME/.ssh/id_rsa $HOSTFS $MOUNTPOINT

