#!/bin/bash


# while 
# counter=0
# echo $ counter
# while   [[ $ counter -lt $ 1 ]]; do
#     echo $ 2 
#     counter=0
# done

#for
# for((i=0;i<$ 1;i+=1)); do 
# echo $ i
# done
# # for ((init;condition;after))
# # init - difindes the varibel
# # con - condition 
# # after - what hapend to the variable

#-eq: Equal to (for numbers)
#-ne: Not equal to
#-gt: Greater than
#-lt: Less than
#-ge: Greater than or equal to
#-le: Less than or equal to

#CLI Arguments
# $ 0 - The name of the script itself
# $ 1, $ 2, $ 3, etc. - The first, second, third, etc. arguments
# $ @ - All arguments as separate strings
# $ * - All arguments as a single string
# $ # - The number of arguments

echo hello i am file utilty lets start

list_files_by_size() {
    local path="$1"
    local order="$2"
    
    echo "Listing files by size (${order}):"
    echo "================================="
    
    if [[ "$order" == "asc" ]]; then
        # Ascending order (smallest first)
        find "$path" -type f -printf "%s\t%p\n" | sort -n | awk '{
            size = $1;
            $1 = "";
            sub(/^ /, "");
            if (size < 1024) {
                printf "%8d B\t%s\n", size, $0;
            } else if (size < 1048576) {
                printf "%8.2f KB\t%s\n", size/1024, $0;
            } else if (size < 1073741824) {
                printf "%8.2f MB\t%s\n", size/1048576, $0;
            } else {
                printf "%8.2f GB\t%s\n", size/1073741824, $0;
            }
        }'
    else
        # Descending order (largest first)
        find "$path" -type f -printf "%s\t%p\n" | sort -nr | awk '{
            size = $1;
            $1 = "";
            sub(/^ /, "");
            if (size < 1024) {
                printf "%8d B\t%s\n", size, $0;
            } else if (size < 1048576) {
                printf "%8.2f KB\t%s\n", size/1024, $0;
            } else if (size < 1073741824) {
                printf "%8.2f MB\t%s\n", size/1048576, $0;
            } else {
                printf "%8.2f GB\t%s\n", size/1073741824, $0;
            }
        }'
    fi
}





