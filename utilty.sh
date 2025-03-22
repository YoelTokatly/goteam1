



# Function to list files sorted by size
list_files_by_size() {
read -p "please enter a folder name" path
read -p "asc ot desc" order
    
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

# Function to count files by extension and show size
count_files_by_extension() {
    local path="$1"
    
    echo "File count and size by extension:"
    echo "================================="
    
    # Use temporary file to avoid subshell variables loss
    temp_file=$(mktemp)
    
    # Find all files and process
    find "$path" -type f | while read -r file; do
        # Get extension (everything after the last dot)
        filename=$(basename "$file")
        if [[ "$filename" == *.* ]]; then
            ext="${filename##*.}"
        else
            ext="no_extension"
        fi
        
        # Get file size in bytes
        size=$(stat -c %s "$file" 2>/dev/null || stat -f %z "$file" 2>/dev/null)
        
        # Append to temp file: extension and size
        echo "$ext $size" >> "$temp_file"
    done
    
    # Process the temp file
    awk '
    {
        ext = $1;
        size = $2;
        count[ext]++;
        total[ext] += size;
    }
    END {
        printf "%-15s %-10s %-15s\n", "EXTENSION", "COUNT", "TOTAL SIZE";
        printf "%-15s %-10s %-15s\n", "=========", "=====", "==========";
        for (e in count) {
            size_str = "";
            size_mb = total[e] / (1024*1024);
            
            if (size_mb < 0.01) {
                size_kb = total[e] / 1024;
                size_str = sprintf("%.2f KB", size_kb);
            } else if (size_mb < 1000) {
                size_str = sprintf("%.2f MB", size_mb);
            } else {
                size_gb = size_mb / 1024;
                size_str = sprintf("%.2f GB", size_gb);
            }
            
            printf "%-15s %-10d %-15s\n", "."e, count[e], size_str;
        }
    }' "$temp_file" | sort -k2 -nr
    
    # Clean up
    rm "$temp_file"
}

# Function to check folder size
check_folder_size() {
    local path="$1"
    local threshold="$2"  # In MB
    local action="$3"
    
    echo "Folder size analysis:"
    echo "====================="
    
    # Calculate folder size in bytes
    local size_bytes=$(du -sb "$path" | cut -f1)
    local size_mb=$(echo "scale=2; $size_bytes / (1024*1024)" | bc)
    local size_gb=$(echo "scale=2; $size_bytes / (1024*1024*1024)" | bc)
    
    # Display size
    if (( $(echo "$size_mb < 1000" | bc -l) )); then
        echo "Folder '$path' size: ${size_mb} MB"
    else
        echo "Folder '$path' size: ${size_gb} GB"
    fi
    
    # Check against threshold

    if (( $(echo "$size_mb > $threshold" | bc -l) )); then
        echo "WARNING: Folder size exceeds threshold of ${threshold} MB!"        
        case "$action" in
            echo)
                echo "No action taken. Use --action compress or --action delete for suggestions."
                ;;
            compress)
                echo "Suggestion: Consider compressing these large files:"
                find "$path" -type f -size +10M -printf "%s\t%p\n" | sort -nr | head -10 | 
                awk '{
                    size = $1;
                    $1 = "";
                    sub(/^ /, "");
                    if (size < 1048576) {
                        printf "%8.2f KB\t%s\n", size/1024, $0;
                    } else if (size < 1073741824) {
                        printf "%8.2f MB\t%s\n", size/1048576, $0;
                    } else {
                        printf "%8.2f GB\t%s\n", size/1073741824, $0;
                    }
                }'
                echo
                echo "To compress a file: tar -czf filename.tar.gz filename"
                ;;
            delete)
                echo "Suggestion: Consider deleting these files to free up space:"
                echo "NOTE: Always verify before deletion!"
                
                # Temp files
                echo "Temporary files:"
                find "$path" -name "*.tmp" -o -name "*.temp" -o -name "*.bak" | head -5
                
                # Duplicate files (simple check by size, would need more sophisticated tools for true dupes)
                echo
                echo "Possible large duplicates (same size files):"
                find "$path" -type f -size +1M -printf "%s\n" | sort -n | uniq -d | 
                xargs -I{} find "$path" -type f -size {}c -printf "%s\t%p\n" | sort | head -10
                
                # Large files
                echo
                echo "Largest files:"
                find "$path" -type f -printf "%s\t%p\n" | sort -nr | head -10 | 
                awk '{
                    size = $1;
                    $1 = "";
                    sub(/^ /, "");
                    if (size < 1048576) {
                        printf "%8.2f KB\t%s\n", size/1024, $0;
                    } else if (size < 1073741824) {
                        printf "%8.2f MB\t%s\n", size/1048576, $0;
                    } else {
                        printf "%8.2f GB\t%s\n", size/1073741824, $0;
                    }
                }'
                ;;
        esac
    else
        echo "Folder size is within the threshold of ${threshold} MB."
    fi
}

# Set default values
# PATH_TO_CHECK="."
# LIST_ORDER="desc"
# SIZE_THRESHOLD=100  # MB
# ACTION="echo"


start() {
    echo "Welcome to the utility"
    echo
    echo "Options:"
    echo "   l,  List files by size count files of folders by size"
    echo "   c,  count files of folders by size"
    echo "   f,  show folder total size"
    echo "   e,  Nothing to do stop Manger consol"
}

start
read -p "what do whant to do?" userrespond
    case "$userrespond" in
        l)
            # f_utilty
            list_files_by_size
        
            exit 0
            ;;
        c)
            # f_read
            count_files_by_extension
            ./read_file.sh
            ;;
        f)
            # f_delete
            
            check_folder_size
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


# # Process command line arguments

# # Verify path exists
# if [[ ! -d "$PATH_TO_CHECK" ]]; then
#     echo "Error: Path '$PATH_TO_CHECK' does not exist or is not a directory!"
#     exit 1
# fi

# # If no options were specified, show help
# if [[ -z "$DO_LIST" && -z "$DO_COUNT" && -z "$DO_SIZE" ]]; then
#     show_help
#     exit 0
# fi

# # Execute requested functions
# if [[ "$DO_LIST" == true ]]; then
#     list_files_by_size "$PATH_TO_CHECK" "$LIST_ORDER"
#     echo
# fi

# if [[ "$DO_COUNT" == true ]]; then
#     count_files_by_extension "$PATH_TO_CHECK"
#     echo
# fi

# if [[ "$DO_SIZE" == true ]]; then
#     check_folder_size "$PATH_TO_CHECK" "$SIZE_THRESHOLD" "$ACTION"
# fi


exit 0





