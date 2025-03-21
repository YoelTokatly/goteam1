#!/bin/bash

# This script lists all files in the current directory and sorts them by size.

# List & Sort Function
sort() {
    printf "\n~~~ Listing and sorting by size ~~~\n\n"
    ls -lS
}

sort
