#!/bin/bash

pactl move-sink-input $(pactl list short sink-inputs | head -1 | tr '\t' ' ' | cut -d' ' -f1) alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.iec958-stereo
