#!/bin/bash

echo $$ > task6_handler.pid

x=1
mode="+"

sigterm()
{
	echo "exit"
	rm task6_handler.pid
	exit
}

usr1()
{
	mode="+"
}

usr2()
{
	mode="*"
}

trap "sigterm" SIGTERM
trap "usr1" USR1
trap "usr2" USR2

while true
do
	echo $x
	sleep 1
	case $mode in
		"+")
			x=$(($x + 2))
			;;
		*)
			x=$(($x * 2))
			;;
	esac
done
