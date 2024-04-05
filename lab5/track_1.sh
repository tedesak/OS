#!/bin/bash

track_log="track_log_1"
./mem.bash & pid_mem=$!
start_time=$(date +%s)
echo "SEC MEM SWAP CPU_SCRIPT MEM_SCRIPT" > $track_log
while true
do
	dump=$(top -n 1 | grep "mem.bash")
	if [[ -z $dump ]]
	then 
		break 
	fi
	time_diff=$(( $(date +%s) - $start_time ))
	mem=$(top -n 1 | head -4 | tail -1 | awk '{print $6}')
	swap=$(top -n 1 | head -5 | tail -1 | awk '{print $5}')
	cpu_script=$(top -n 1 -p $pid_mem | head -8 | tail -1 | awk '{print $10}')
	mem_script=$(top -n 1 -p $pid_mem | head -8 | tail -1 | awk '{print $11}')
	echo $time_diff $mem $swap $cpu_script $mem_script
	sleep 1
done >> $track_log

dmesg | grep "mem.bash" >> $track_log