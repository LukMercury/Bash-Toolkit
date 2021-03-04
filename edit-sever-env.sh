#!/bin/bash

DATA_FOLDER=$HOME/Scripts

cd $DATA_FOLDER
echo 'Unpacking...'
tar -xzvf server-env.tar.gz
vim server-env.sh
echo 'Packing...'
tar --remove-files -czvf server-env.tar.gz server-env.sh darkcourses_green.ini
echo 'Done.'
