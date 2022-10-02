#!/bin/bash

wpctl set-default $(wpctl status | grep FiiO | grep Digital | tr -d '*.' | tr -s ' ' | cut -d' ' -f3)

COUNT=$(pactl list short sink-inputs | wc -l)

for i in $(seq $COUNT); do

pactl move-sink-input $(pactl list short sink-inputs | head -n $i | tail -1 | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K5_Pro-00.iec958-stereo

done
