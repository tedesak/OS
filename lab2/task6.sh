#!/bin/bash
function get_info() {
pid=$1
if  test -d "/proc/${pid}"
then
	echo $1 $(($(cat /proc/${pid}/stat | awk '{print 4*$24}') * $(getconf PAGESIZE)))
fi
}

export -f get_info

ps -Ao pid |
xargs -I {} /bin/bash -c "get_info {}" |
sort -n -k2 -r |
head -1 |
grep -o "^[0-9]*"
