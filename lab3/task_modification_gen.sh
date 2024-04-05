#!/bin/bash

echo $$ > task_modification.pid

if [ ! -p task_modification_pipe ]
then
	mkfifo task_modification_pipe
fi

while true
do
	read line
	echo "$line" > task_modification_pipe

	case $line in
                [0-2]" "[0-2]) ;;
                "QUIT")
                        echo "exit"
			rm task_modification_pipe
                        rm task_modification.pid
			exit 0
                        ;;
                *)
                        echo "invalid input"
                        rm task_modification_pipe
			rm task_modification.pid
			exit 1
                        ;;
        esac
done
