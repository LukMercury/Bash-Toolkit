#!/bin/bash

# mount and unmount remote file systems
# "lazy" filesystems can't be unmounted without "-l" because they are still in use by processes like vscode

IP=192.168.0.101

if [[ $1 == "u" ]]; then
    umount /mount/point/not/lazy &> /dev/null
    umount -l /mount/point/lazy &> /dev/null
    exit 0
fi

sshfs -o IdentityFile=/home/mercury/.ssh/id_rsa mluca@${IP}:/remotefs/not/lazy /mount/point/not/lazy
sshfs -o IdentityFile=/home/mercury/.ssh/id_rsa mluca@${IP}:/remotefs/lazy /mount/point/lazy

