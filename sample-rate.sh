#!/bin/bash

SETTINGS_FILE=/etc/pulse/daemon.conf

grep '; default-sample-format = s16le' $SETTINGS_FILE > /dev/null

if [ $? -eq 0 ]; then 
	sudo sed -i 's/default-sample-format = s32le/; default-sample-format = s32le/' $SETTINGS_FILE
	sudo sed -i 's/; default-sample-format = s16le/default-sample-format = s16le/' $SETTINGS_FILE

	sudo sed -i 's/default-sample-rate = 192000/; default-sample-rate = 192000/' $SETTINGS_FILE
	sudo sed -i 's/; default-sample-rate = 44100/default-sample-rate = 44100/' $SETTINGS_FILE

	echo 'sampling set to LOW'
else
	sudo sed -i 's/default-sample-format = s16le/; default-sample-format = s16le/' $SETTINGS_FILE
	sudo sed -i 's/; default-sample-format = s32le/default-sample-format = s32le/' $SETTINGS_FILE

	sudo sed -i 's/default-sample-rate = 44100/; default-sample-rate = 44100/' $SETTINGS_FILE
	sudo sed -i 's/; default-sample-rate = 192000/default-sample-rate = 192000/' $SETTINGS_FILE

	echo 'sampling set to HIGH'
fi

pulseaudio -k