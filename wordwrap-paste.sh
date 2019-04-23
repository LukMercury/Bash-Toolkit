#!/bin/bash

xclip -selection c -o | tr '\n' ' ' | xclip -selection c
