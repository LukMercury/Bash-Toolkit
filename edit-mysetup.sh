#!/bin/bash

tar -xzvf mysetup.tar.gz
vim mysetup.sh
tar -czvf mysetup.tar.gz mysetup.sh darkcourses_green.ini
rm mysetup.sh
