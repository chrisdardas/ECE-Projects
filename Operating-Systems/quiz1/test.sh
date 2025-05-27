#! /usr/bin/env bash

var=$1

files=$(($var + 10))


words=('super' 'bat' 'spider')

# for ((i=1 ; i<=files; i++));do
#     cat /dev/urandom | tr -dc 'a-z' | head -c $((($RANDOM % 3) + 6)) | xargs -I file touch file-$i.txt
# done

# cat /dev/urandom | tr -dc "a-z" | head -c $((($RANDOM % 3) + 6)) | xargs -I file_name bash -c 'touch file_name-{1..'"$files"'}.txt'
# find . -name "*.txt*" 
cat /dev/urandom | tr -dc 'a-z' | head -c $((($RANDOM % 3) + 6)) > randomword
for ((i=1; i<="$files"; i++)); do
    cat randomword | xargs -I filename touch filename-$i.txt
done

for file in $(find . -name "*.txt"); do
    shuf -n "$files" -r -e ${words[@]} > "$file"
done

for file in $(ls -t *.txt | sort -t'-' -k2,2n); do
    echo "$PWD/$file" >> report.txt
    grep "super"   "$file" -c | xargs -I number echo "number super"   >> report.txt
    grep "spider"  "$file" -c | xargs -I number echo "number spider"  >> report.txt
    grep "bat"     "$file" -c | xargs -I number echo "number bat"     >> report.txt
    echo >> report.txt
done

# for file in $(ls *.txt | sort -t'-' -k2,2n); do
#     # Print the file path
#     echo "$PWD/$file" >> report.txt
    
#     # Get the counts for each word
#     super_count=$(grep "super" "$file" -c)
#     spider_count=$(grep "spider" "$file" -c)
#     bat_count=$(grep "bat" "$file" -c)
    
#     # Store the counts with their labels in an array
#     counts=("$super_count super" "$spider_count spider" "$bat_count bat")
    
#     printf "%s\n" "${counts[@]}" | sort -nr >> report.txt
    
#     # Add a blank line after each file's results
#     echo >> report.txt
# done
