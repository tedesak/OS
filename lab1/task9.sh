#!/bin/bash 
acc=0
for file in $(find /var/log -type f -name "*.log")
do
    acc=$(($acc + $(cat $file | wc -l)))
done
echo $acc
