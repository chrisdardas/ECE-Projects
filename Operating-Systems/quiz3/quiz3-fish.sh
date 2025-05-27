#! /usr/bin/env fish

if test (count $argv) -lt 1 

	echo "No file provided"
	exit 1
end

set -l usernames $argv[1]
set -l file $argv[2]

set -l users (cat $usernames)

for user in $users
	echo $user
end

for user in $users
	set -l home_directory /home/$user
	set -l file_directory (find $home_directory -name $file 2>/dev/null | head -n 1)

	if test -d "$home_directory"
		if test -f "$file_directory" 
			if test -r "$file_directory"
				set -l size (ls -l $file_directory | grep $file | awk '{print $5}')
				echo "File requested : "\"$file"\" returned File found and of size $size bytes."
			else
				echo "File requested: "\"$file"\" returned Permission Denied."
			end
		else
			echo "File requested: "\"$file"\" returned File not found."
		end
	end
end
