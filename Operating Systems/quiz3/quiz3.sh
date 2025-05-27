#! /usr/bin/env bash

usernames=$1
file=$2

# checking if both arguments have been provided to run the script
if [ -z "$usernames" ] || [ -z "$file" ]; then
    echo "Usage: $0 <usernames_file> <filename>"
    echo "Both arguments are required."
    exit 1
fi

if [ ! -f "$usernames" ]; then
	echo "No file $usernames was provided"
	echo "Exiting..."
	exit 1
fi

# if [ ! -f "$file" ]; then
#	echo "No file provided"
#	check_file=0
#else
#	check_file=1
#fi
check_file=1
users=($(<$usernames))
# echo "${#users[@]}"

for name in "${users[@]}"; do
	if [ "$check_file" -eq 1 ]; then
		home_directory="/home/$name"
		if [ -d  "$home_directory" ]; then
			files=$(find "$home_directory"  -name "$file" 2>/dev/null)
			# echo "File Directory($name) : $files"
			echo "$files" | while read -r file_directory; do
				# echo "$file_directory"
				if [ -f  "$file_directory" ]; then
					if [  -r "$file_directory" ]; then
						size=$(ls -l "$file_directory" | grep "$file" | awk '{print $5}')
						echo  "File requested: "\"$file"\" returned File found and of size $size of bytes"
					else
						echo "File requested: "\"$file"\" returned Permission denied"
					fi
				else
					echo "File requested: "\"$file"\" returned File not found."
				fi
			done
		fi
	fi
done
