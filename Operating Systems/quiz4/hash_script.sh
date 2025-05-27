#! /usr/bin/env bash

echo "Enter a 4-digit number: "
regex='^[0-9]{4}$'

while true; do
	read -r num
	if echo "$num" | grep -E "$regex"; then
		break
	else
		echo "Wrong Input"
		echo "Enter a 4-digit number"
	fi
done

echo -n "$num" | sha256sum | awk '{print $1}' > hash_output.txt

echo "Hash created successfully"
