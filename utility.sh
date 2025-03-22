#!/bin/bash

# list files sorted by size
list_files() {
    read -p "sort by (asc/desc): " order
    if [[ "$order" == "asc" ]]; then
        ls -lS | grep '^-' | awk '{print $9, $5}'
    elif [[ "$order" == "desc" ]]; then
        ls -lSr | grep '^-' | awk '{print $9, $5}'
    else
        echo "invalid option!"
    fi
}

# count files by extension and show total size
count_files_by_extension() {
    read -p "enter file extension (without .): " ext
    count=$(find . -type f -name "*.$ext" | wc -l)
    size=$(du -ch *.$ext 2>/dev/null | grep total$ | awk '{print $1}')
    echo "found $count .$ext files (size: $size)"
}

# show folder total size
folder_size() {
    size=$(du -sh . | awk '{print $1}')
    echo "total folder size: $size"
}

# menu
echo "utility script options:"
echo "1 - list files sorted by size"
echo "2 - count files by extension and total size"
echo "3 - show folder total size"
read -p "enter your choice (1-3): " choice

if [[ "$choice" == "1" ]]; then
    list_files
elif [[ "$choice" == "2" ]]; then
    count_files_by_extension
elif [[ "$choice" == "3" ]]; then
    folder_size
else
    echo "invalid option!"
fi
