#!/bin/bash

DATA_FOLDER=$HOME/Dropbox/Bash-Scripts

cd $DATA_FOLDER
echo 'Unpacking...'
tar -xzvf server-env.tar.gz
vim server-env.sh
tar --remove-files -czvf server-env.tar.gz server-env.sh darkcourses_green.ini
echo 'Packing...'
#cd -
