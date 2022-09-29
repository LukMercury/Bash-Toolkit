#!/bin/bash

pactl move-sink-input $(pactl list short sink-inputs | head -1 | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K5_Pro-00.iec958-stereo
