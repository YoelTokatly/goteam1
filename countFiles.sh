#!/bin/bash

# This script counts the number of files in the current directory with a specific extension.

countFiles() {
    echo -e "\n\033[37;40;1m ~~~ Counting files with extension ~~~ \033[0m\n\n"
    read -p "Enter the file extension (e.g., txt, jpg): " ext
    echo " "
    echo -e "Counting files with extension \033[31;1m.$ext\033[0m in the current directory..."
    echo -e "Number of files with extension \033[31;1m.$ext\033[0m: "
    num=$(find -maxdepth 1 -type f -name "*.$ext" | wc -l)
    echo " "
    echo -e "\033[31;1m$num\033[0m"
}

countFiles

# This script calculates the total size of all files with a specific extension in the current directory.
filesSizeArray=$(ls -l | grep -E "\.$ext$" | awk '{print $5}')

echo " "

# This script calculates the total size of all files with a specific extension in the current directory.

fileSize() {
    sum=0
    for size in $filesSizeArray; do
        sum=$((sum + size))
    done
    echo -e "Total size of all \033[31;1m.$ext\033[0m files: \033[31;1m$sum\033[0m bytes"
    echo " "
}

fileSize

# This script calculates the total size of all files in the current directory.
echo -e "\033[37;40;1m~~~ Calculating total size of all files in the current directory ~~~\033[0m"
currentFolder=$(basename "$(pwd)")

currentFolderSizer() {
    echo " "
    echo -e "Total size of the current folder \033[31;1m$currentFolder\033[0m : "
    #ls -l .. | grep "$currentFolder" | awk '{printf $5}'
    echo -e "\033[31;1m$(ls -l .. | grep "$currentFolder" | awk '{printf $5}')\033[0m Bytes"
    echo " "
}

currentFolderSizer

#\033[37;40;1m  \033[0m
