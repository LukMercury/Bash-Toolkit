#!/bin/bash

xclip -selection c -o | tr -s [:space:] ' ' | xclip -selection c
