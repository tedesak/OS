#!/bin/bash

while true
do
	read line
	pid=$(cat task6_handler.pid)

	case $line in
                TERM)
			kill -SIGTERM $pid
			echo "exit"
			exit
			;;
                "+")
			kill -USR1 $pid
			;;
                "*")
                        kill -USR2 $pid
                        ;;
                *)
                        continue
                        ;;
        esac
done
