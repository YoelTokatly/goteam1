#! /bin/bash
#function count_lines {
while read line;do 
echo $line
#echo "words: $(wc -w) lines: $(wc -l) total size: $(wc -c) bytes" 
done <file 
echo "words: $(wc -w file | cut -d' ' -f1) lines: $(wc -l file | cut -d' ' -f1) total size: $(wc -c file | cut -d' ' -f1)"
#}

#function search {
read -p "Enter a text to search in file: " text
#cat file | grep -q $text
#status=$?
#if [[ status -eq 0 ]];then
#cat file | grep $text
#if 
status=$(grep -o $text file)
if [[ $status -eq 0 ]];then
word_num=$(grep -ob $text file)
echo "true, word num line is $word_num"
else echo "error" 
fi

#grep $1 file
#}
#search hello
#if [[ -z $1]];then
#count_line |  
#count_lines 
