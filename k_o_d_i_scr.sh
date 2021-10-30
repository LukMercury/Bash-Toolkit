#!/bin/bash

export DISPLAY=:0

if [ ! -z "$(ps -e | grep -i kodi)" ] && [ -z "$(ps -e | grep -i caffeine)" ]; then
    nohup caffeine &> /dev/null
    exit 0
fi

if [ -z "$(ps -e | grep -i kodi)" ] && [ ! -z "$(ps -e | grep -i caffeine)" ]; then
    pkill caffeine
    exit 0
fi

