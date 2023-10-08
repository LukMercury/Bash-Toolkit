#!/bin/bash

nohup /opt/pcpanel/bin/PCPanel &> /dev/null &

sleep 3

xdotool search --onlyvisible --name PcPanel windowactivate
xdotool mousemove 1438 98
xdotool click 1

