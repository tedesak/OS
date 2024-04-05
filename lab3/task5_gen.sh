#!/bin/bash

if [ ! -p task5_pipe ]
then
	mkfifo task5_pipe
fi

while true
do
	read line
	echo "$line" > task5_pipe

	case $line in
                ["+","*"]) ;;
                [0-9]*) ;;
                "QUIT")
                        echo "exit"
			rm task5_pipe
                        exit 0
                        ;;
                *)
                        echo "invalid input"
                        rm task5_pipe
			exit 1
                        ;;
        esac
done
