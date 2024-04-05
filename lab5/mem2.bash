#!/bin/bash
> report2.log
array=()
i=0
while true
do
	if [[ $((i % 100000)) == 0 ]] 
	then
		echo "${#array[@]}" >> report2.log
	fi	
	array+=(0 1 2 3 4 5 6 7 8 9)
	(( i++ ))
done
