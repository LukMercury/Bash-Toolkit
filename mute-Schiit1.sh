#!/bin/bash

pactl set-sink-mute $(pactl list short sinks | grep 'Modi_3E-00' | tr '\t' ' ' | cut -d' ' -f1)  toggle
