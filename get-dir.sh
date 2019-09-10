#!/bin/bash

sed -i "s|export CURRENT_DIR=.*|export CURRENT_DIR=$PWD|" $HOME/.profile

