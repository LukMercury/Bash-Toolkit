#!/bin/bash

if [ -z $1 ]; then
    IP=8.8.8.8
else
    IP="$1"
fi

cmusPlayIfRunningAndExitScript()
{
	ps -e | grep cmus | grep -v \<defunct\> &> /dev/null && cmus-remote -p &> /dev/null && exit 0
}


tmuxStartIfNotRunning()
{

	ps -e | grep tmux | grep -v \<defunct\> &> /dev/null || tmux new-session -d 
}

cmusStartPlayAndExitScript() 
{
    tmux new-window -ncmus 'cmus'
    tmux swap-window -t 0
    sleep 1

	while (true); do 
		cmus-remote -p &> /dev/null
		if [ $? -eq 0 ]; then
			break
		fi
	done
    exit 0
}

waitToRetry()
{
    counter=$1
    while [ $counter -ne 0 ]; do
        echo -en "\r$counter \b"
        counter=$(($counter - 1)) 
        sleep 1
    done
    echo -en "\r"
}

while (true); do

    ping -c1 $IP

    if [ $? -eq 0 ]; then

    	cmusPlayIfRunningAndExitScript		

		tmuxStartIfNotRunning

		cmusStartPlayAndExitScript

    fi

    waitToRetry 300 # seconds 

done
