#!/bin/bash

# get folder size and file count
get_folder_info() {
    echo "folder: $1"
    echo "total files: $(find "$1" -type f | wc -l)"
    echo "total size: $(du -sh "$1" | awk '{print $1}')"
}

# delete all files in a folder
delete_all_files() {
    get_folder_info "$1"
    read -p "are you sure you want to delete all files in $1? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        find "$1" -type f -exec rm -f {} +
        echo "all files deleted from $1!"
    else
        echo "deletion canceled!"
    fi
}

# delete files by extension with improved error handling
delete_by_extension() {
    count=$(find "$1" -type f -name "*.$2" | wc -l)
    
    if [[ "$count" -eq 0 ]]; then
        echo "no .$2 files found in $1"
        return
    fi

    echo "found $count *.$2 files"
    read -p "are you sure you want to delete all *.$2 files? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        find "$1" -type f -name "*.$2" -exec rm -f {} +
        echo "all .$2 files deleted!"
    else
        echo "deletion canceled!"
    fi
}

# menu
echo "delete script options:"
echo "1 delete all files in a folder"
echo "2 delete files by extension"
read -p "enter your choice (1/2): " choice

if [[ "$choice" == "1" ]]; then
    read -p "enter the folder path: " folder
    delete_all_files "$folder"

elif [[ "$choice" == "2" ]]; then
    read -p "enter the folder path: " folder
    read -p "enter the file extension (without .): " ext
    delete_by_extension "$folder" "$ext"

else
    echo "invalid option!"
fi
