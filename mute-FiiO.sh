#!/bin/bash

pactl set-sink-mute $(pactl list short sinks | grep FiiO | tr '\t' ' ' | cut -d' ' -f1)  toggle
