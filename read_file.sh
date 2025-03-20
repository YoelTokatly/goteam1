#! /bin/bash
function count_lines {
read -p "Enter a file name to read: " file
while read line;do 
echo $line
done < $file
echo "words: $(wc -w $file | cut -d' ' -f1) lines: $(wc -l $file | cut -d' ' -f1) total size: $(wc -c $file | cut -d' ' -f1)"
}

function search {
read -p "Enter a word to search in $file: " word 
grep -q -w $word $file                 # -q for quiet mode, -w for printing the whole word only. 
status=$?
if [[ $status -eq 0 ]];then
word_location=$(grep -bow "$word" "$file" | cut -d ':' -f1)   # -b for the word location in bytes
echo "True, word location is - $word_location" 
fi
}

#Calling the functions
count_lines
search
