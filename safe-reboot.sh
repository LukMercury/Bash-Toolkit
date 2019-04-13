#!/bin/bash

tmux attach 2> /dev/null || echo "No tmux session active."
echo "Restarting..."
reboot
