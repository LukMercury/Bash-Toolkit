#!/bin/bash

ARG="$(echo $1 | tr '[:upper:]' '[:lower:]')"

case "$ARG" in
    "pst")
        TIME_ZONE="America/Los_Angeles"
        ;;
    "syd")
        TIME_ZONE="Australia/Sydney"
        ;; 
    "")
        TIME_ZONE="Europe/Bucharest"
        ;;
    *)
        echo "Add time zone (tzselect)"    
        exit 1
        ;;
esac

while true
do
    clear
    TZ="$TIME_ZONE" date | tr -s ' ' | cut -d' ' -f4 | cut -d: -f1-2
    sleep 1
done
