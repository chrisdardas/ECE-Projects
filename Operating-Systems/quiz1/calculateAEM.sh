#! /usr/bin/env bash

echo 'Enter you AEM : '
read -r AEM

len=${#AEM}

for ((i = 1; i <= ${len}; i++));do
	mod=$(($AEM % 10))
	sum=$(($sum + $mod))
	AEM=$(($AEM / 10))
done

if [[ "$sum" -ge 10 ]];then
	a=$(($sum % 10))
	b=$(($sum / 10))
	sum=$(($a + $b))
	echo "$sum" > sum
else
	echo "$sum" > sum
fi
