#!/bin/bash

COUNT=$(pactl list short sink-inputs | wc -l)

for i in {1..$COUNT}; do

pactl move-sink-input $(pactl list short sink-inputs | head -n $COUNT | tail -n $i | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K5_Pro-00.iec958-stereo

done
