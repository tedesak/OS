#!/bin/bash

d=$(date +"%F_%T")

mkdir ~/test 2>/dev/null && {
echo "catalog test was created successfully" > ~/report
touch ~/test/$d
}

ping "www.net_nikogo.ru" 2>/dev/null || echo "$d: can't find host" >> ~/report

#2>/dev/null redirect error messages to special file for ignoring unnecessary messages
