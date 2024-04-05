#!/bin/bash

if [[ (! -f ~/.trash.log) || (! -d ~/.trash) ]]
then
	echo "Trash files are incomplete"
	exit 1
fi
f=0

IFS=$'\n'

for log in $(cat ~/.trash.log)
do
	name=$(echo $log | rev | cut -d "/" -f 2 | rev)
	if [[ ( -z "$name" ) || "$name" != "$1" ]]
	then
		continue
	fi
	f=1
	path=$(echo $log | rev | cut -d "/" -f 2- | rev)
    	name_trash=$(echo $log | rev | cut -d "/" -f 1 | rev)
	echo "Untrash \"$name_trash\" to $path? (Print \"y\" for untrash)"
	read ans
	if [[ (! -z $ans) && $ans == "y" ]]
	then
		dir_path=$(echo "$path" | rev | cut -d '/' -f 2- | rev)
		name=$(echo "$path" | rev | cut -d '/' -f 1 | rev)
		if [ ! -d "$dir_path" ]
		then
			echo "$dir_path" "doesn't exist: untrash into home_dir"
			dir_path=~
		fi
		if [ -f $dir_path/"$name" ]
		then
			echo "$name already exist: enter new name"
			read name
		fi
		ln ~/.trash/"$name_trash" $dir_path/"$name"
		rm ~/.trash/"$name_trash"
		sed -i '/'"${name_trash}"'/d' ~/.trash.log
	fi
done

if [[ $f == 0 ]]
then
	echo "File doesn't exist in trash"
	exit 1
fi
#}
