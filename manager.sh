#!/bin/bash

# menu options
echo "folder manager options:"
echo "1 - utility script"
echo "2 - read file script"
echo "3 - delete script"
echo "4 - exit"

# get user choice
read -p "enter your choice (1-4): " choice

# execute the selected script
if [[ "$choice" == "1" ]]; then
    ./utility.sh
elif [[ "$choice" == "2" ]]; then
    ./readfile.sh
elif [[ "$choice" == "3" ]]; then
    ./delete.sh
elif [[ "$choice" == "4" ]]; then
    echo "exiting..."
    exit 0
else
    echo "invalid option!"
fi
