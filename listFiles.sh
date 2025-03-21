#!/bin/bash

# This script lists all files in the current directory and sorts them by size.

# List & Sort Function
sort() {
    echo -e "\n\033[37;40;1m~~~ Listing and sorting by size ~~~\033[0m\n"
    ls -lS
}

sort

#Running the countFiles.sh script
./countFiles.sh

#\033[37;40;1m \n~~~ Listing and sorting by size ~~~\n\n \033[0m
