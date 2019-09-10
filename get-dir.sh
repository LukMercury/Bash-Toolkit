#!/bin/bash

sed -i "s|export DIR=.*|export DIR=$PWD|" $HOME/.profile

