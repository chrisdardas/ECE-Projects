#! /usr/bin/env bash

usernames=$1
file=$2

if [ ! -f "$usernames" ]; then
	echo "No file $usernames was provided"
	echo "Exiting..."
	exit 1
fi

if [ ! -f "$file" ]; then
	echo "No file provided"
	check_file=0
else
	check_file=1
fi

users=($(<$usernames))
# echo "${#users[@]}"

for name in "${users[@]}"; do
	echo $name
	echo "##########"
	echo "Last login date(s):"
	last -n 10 $name | awk 'NF==10 {print $4,$5,$6,$7}'
	echo "Last login IP(s)/hostnames(s):"
	# last -n 10 $name | awk 'NF==10 && $3 !~ /tmux/ {print $3}' | xargs -I ip host ip | awk '{print $NF}'


	# last -n 10 $name | awk 'NF==10 && $3 !~ /tmux/ {print $3}'
	# last -n 10 $name | awk 'NF==10 && $3 !~ /tmux/ {print $3}' | xargs -I ip nslookup ip | grep "name" | awk '{print $NF}'

	last -n 10 $name | awk 'NF==10 && $3 !~ /tmux/ {print $3}' | while read ip;do
		echo $ip ; nslookup $ip | grep "name" | awk '{print $NF}'
	done

	echo -n -e "\n\n"
	if [ "$check_file" -eq 1 ]; then
		home_directory="/home/$name"
		file_directory="$home_directory/$file"
		# echo $file_directory
		if [ -d  "$home_directory" ]; then
			echo "$home_directory"
			if [ -f  "$file_directory" ]; then
				if [  -r "$file_directory" ]; then
					size=$(ls -l | grep "$file" | awk '{print $5}')
					echo  "File requested: "\"$file"\" returned File found and of size $size of bytes"
				else
					echo "File requested: "\"$file"\" returned Permission denied"
				fi
			else
				echo "File requested: "\"$file"\" returned File not found."
			fi
		fi
	fi
done
