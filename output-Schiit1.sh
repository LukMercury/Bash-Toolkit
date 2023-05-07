#!/bin/bash

wpctl set-default $(wpctl status | grep 'Modi 3E' | grep Digital | tr -d '*.' | tr -s ' ' | cut -d' ' -f3)

COUNT=$(pactl list short sink-inputs | wc -l)

for i in $(seq $COUNT); do

pactl move-sink-input $(pactl list short sink-inputs | head -n $i | tail -1 | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.iec958-stereo || pactl move-sink-input $(pactl list short sink-inputs | head -n $i | tail -1 | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.2.iec958-stereo

done
