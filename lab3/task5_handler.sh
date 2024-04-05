#!/bin/bash

x=1
mode="+"

if [ ! -p task5_pipe ]
then
        mkfifo task5_pipe
fi

(tail -f task5_pipe) |
while true
do
	read line

	case $line in
		["+","*"])
			mode=$line
			echo "chmod to $line"
			;;
		[0-9]*)
			case $mode in
				"+")
					x=$(($x + $line))
					;;
				*)
					x=$(($x * $line))
					;;
			esac
			echo $x
			;;
		"QUIT")
			echo "exit"
			killall tail
			exit 0
			;;
		*)
			echo "invalid input"
			killall tail
			exit 1
			;;
	esac
done

