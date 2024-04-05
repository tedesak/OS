#!/bin/bash
function get_info() {
pid=$1
cmd=$(echo $@ | cut -d ' ' -f 2-)
if test -d "/proc/${pid}"
then
	rchar=$(sudo cat "/proc/$pid/io" | awk '/rchar/ {print $2}')
	echo "$pid $rchar $cmd"
fi
}

function get_info_dif() {
pid=$1
cmd=$(echo $@ | cut -d ' ' -f 3-)
last_rchar=$2
if test -d "/proc/${pid}"
then
        rchar=$(sudo cat "/proc/$pid/io" | awk '/rchar/ {print $2}')
        echo "$pid:$cmd:$(($rchar - $last_rchar))"
fi
}

export -f get_info
export -f get_info_dif

ps -Ao pid,cmd |
tr -d "[()]" |
xargs -I {} /bin/bash -c "get_info {}" |
{
sleep 2
xargs -I {} /bin/bash -c "get_info_dif {}"
} |
sort -t ":" -k3 -n -r |
head -3
