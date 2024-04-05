#!/bin/bash

if [ ! -d ~/.trash ]
then
	mkdir ~/.trash
fi

if [ ! -f "$1" ]
then
	echo "File doesn't exist"
	exit 1
fi

nxt=0
while [[ -f ~/.trash/"$1_$nxt" ]]
do
	nxt=$(($nxt + 1))
done

ln "$1" ~/.trash/"$1_$nxt" 2>/dev/null || {
	echo "Invalid source for hard link"
	exit 1
}

rm "$1"
echo "$PWD/$1/$1_$nxt" >> ~/.trash.log
