#!/bin/bash

pactl set-sink-mute $(pactl list short sinks | grep 'Modi_-00' | tr '\t' ' ' | cut -d' ' -f1)  toggle
