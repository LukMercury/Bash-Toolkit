#!/bin/bash

RemoteMachine="52.50.40.55"

createTunnel() 
{
    /usr/bin/ssh -f -N -R 10022:localhost:22 -L 19922:$RemoteMachine:22 $RemoteMachine
    if [ $? -eq 0 ]; then
        echo "Tunnel to $RemoteMachine created successfully"
    else
        echo "An error occurred creating a tunnel to $RemoteMachine. Return code: $?"
    fi
}

/usr/bin/ssh -p 19922 localhost ls > /dev/null
if [ $? -ne 0 ]; then
    echo "Creating new tunnel connection to $RemoteMachine"
    createTunnel
fi

