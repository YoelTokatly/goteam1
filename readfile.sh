#!/bin/bash

# read file line by line
read_file() {
    read -p "enter file name: " filename
    if [[ ! -f "$filename" ]]; then
        echo "file does not exist!"
        return
    fi
    while IFS= read -r line; do
        echo "$line"
    done < "$filename"
}

# count words, lines, and file size
file_info() {
    read -p "enter file name: " filename
    if [[ ! -f "$filename" ]]; then
        echo "file does not exist!"
        return
    fi
    words=$(wc -w < "$filename")
    lines=$(wc -l < "$filename")
    size=$(du -h "$filename" | awk '{print $1}')
    echo "words: $words, lines: $lines, size: $size"
}

# search for a term inside a file
search_term() {
    read -p "enter file name: " filename
    if [[ ! -f "$filename" ]]; then
        echo "file does not exist!"
        return
    fi
    read -p "enter search term: " term
    if grep -q "$term" "$filename"; then
        echo "term found!"
    else
        echo "term not found!"
    fi
}

# menu
echo "read file script options:"
echo "1 - read file line by line"
echo "2 - count words, lines, and file size"
echo "3 - search for a term inside a file"
read -p "enter your choice (1-3): " choice

if [[ "$choice" == "1" ]]; then
    read_file
elif [[ "$choice" == "2" ]]; then
    file_info
elif [[ "$choice" == "3" ]]; then
    search_term
else
    echo "invalid option!"
fi
