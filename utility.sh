#! /bin/bash
ls -lS

read -p "choose a file extension to search: " ext
count=$(find . -type f -name "*.$ext" | wc -l)
files_size=$(find . -type f -name "*.$ext" -exec du -cm {} + | grep "total" | awk '{print $1}')
echo "$count .$ext files, total size: $files_size"

#Sizes are calculated in MB, -c flag in du is for total size of all ext files.

folder_size=$(du -sm . | awk '{print $1}')
if [[ $folder_size -gt $files_size ]];then
echo "compress/delete the folder"
fi
