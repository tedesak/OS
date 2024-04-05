#!/bin/bash

function completion() {
case $1 in
	"1")
		echo "first"
		;;
	"2")
		echo "second"
		;;
	*)
		echo "draw"
esac
killall tail
kill $(cat task_modification.pid)
rm task_modification.pid
rm task_modification_pipe
exit
}

mode=1
cnt=0
#declare -A - declare associative array
declare -A arr
arr[0,0]=.
arr[0,1]=.
arr[0,2]=.
arr[1,0]=.
arr[1,1]=.
arr[1,2]=.
arr[2,0]=.
arr[2,1]=.
arr[2,2]=.
#all values are different

if [ ! -p task_modification_pipe ]
then
        mkfifo task_modification_pipe
fi

(tail -f task_modification_pipe) |
while true
do
	read line

	case $line in
                [0-2]" "[0-2]);;
                "QUIT")
                        echo "exit"
                        killall tail
			exit
                        ;;
                *)
                        echo "invalid input"
                        killall tail
                        exit 1
                        ;;
        esac

	x=$(echo $line | grep -o "^[0-2]")
        y=$(echo $line | grep -o "[0-2]$")

	if [ ${arr[$x,$y]} == 1 ] || [ ${arr[$x,$y]} == 2 ]
	then
		echo "cell is filled"
		continue
	fi

	arr[$x,$y]=$mode

	echo "-----"
	f=0
	for i in {0..2}
	do
		f1=1
		f2=1
		str=""
		for j in {0..2}
		do
			str="$str ${arr[$i,$j]}"
			if [ ${arr[$i,$j]} != $mode ]
			then
				f1=0
			fi
			if [ ${arr[$j,$i]} != $mode ]
                        then
                                f2=0
                        fi
		done

		echo $str
		if [ $f1 == "1" ] || [ $f2 == "1" ]
		then
			f=1
		fi
	done

	if [ $f == "1" ]
	then
		completion $mode
	fi

	f1=1
        f2=1
        for i in {0..2}
        do
        	if [ ${arr[$i,$i]} != $mode ]
        	then
        		f1=0
        	fi
        	if [ ${arr[$i,$((2 - i))]} != $mode ]
        	then
        		f2=0
        	fi
        done
        if [ $f1 == "1" ] || [ $f2 == "1" ]
        then
        	completion $mode
        fi

	mode=$((3 - mode))
	cnt=$((cnt + 1))
	if [[ $cnt < "9" ]]
	then
		echo "continue"
	else
		completion 0
	fi
done

