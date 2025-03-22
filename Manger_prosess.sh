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


start() {
    echo "Welcome to the Manger consol"
    echo
    echo "Options:"
    echo "   u,  Start the utilty options: List files / count files of folders by size"
    echo "   r,  Start the read file options: print lines / count words / search"
    echo "   d,  Start the delete options: content of a folder / by file extensions"
    echo "   e,  Nothing to do stop Manger consol"
}

start
read -p "what do whant to do?" userrespond






    case "$userrespond" in
        u)
            # f_utilty
            echo open file utility
            ./utilty2.sh
            exit 0
            ;;
        r)
            # f_read
            echo open file read
            ./read_file.sh
            ;;
        d)
            # f_delete
            echo open file delete
            ./delete.sh            
            ;;
        e)
            echo "O.k BY"
            ;;
        *)
            echo "Unknown option: $userrespond"
            echo "???????????????????????????"
            start
            ;;
    esac





