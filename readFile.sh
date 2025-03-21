#!/bin/bash

# This script reads a file and prints its contents to the console.

: '
while read -r line; do
    echo "$line"
done <"$1"
'

echo " "
echo "$(wc -w "$1" | awk '{print $1}') Words"
echo "$(wc "$1" | awk '{print $1}') Lines"
echo "$(du -h "$1" | awk '{print $1}') File size"
echo " "


read -p "Do you want to search for a word? (y/n): " answer

if [[ $answer == "y" ]]; then
    read -p "Enter the word to search for: " my_word
    else
    echo "No word to search for."
fi


count=1
last_position=0

while read -r line; do
    for word in $line; do
        if [[ "$word" == "$my_word" ]]; then
            echo "Found at position : $count. $word"
            last_position=$count
        fi
        #echo "$count. $word"
        ((count++))
    done
done <"$1"

echo "Total words: $count"
echo "Last position of '$my_word': $last_position"
echo " "
echo "End of file"
echo " "