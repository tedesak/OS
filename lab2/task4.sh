#!/bin/bash
function get_info() {
pid=$1
if  test -d "/proc/${pid}"
then
	ppid=$(grep "PPid:" /proc/${pid}/status |
		egrep -o "[0-9]+")
	art=$(grep "sum_exec_runtime\|nr_switches" /proc/${pid}/sched |
		egrep -o "[0-9]+\.?[0-9]*$" |
		tr '\n' ' ' |
		awk '{print $1/$2}')
	echo "ProcessID=$pid : Parent_ProcessID=|$ppid| : Average_Running_Time=$art"
fi
}

export -f get_info

ps -Ao pid |
xargs -I {} /bin/bash -c "get_info {}" |
sort -t "|" -k2 -n |
tr -d "|" > task4_ans
