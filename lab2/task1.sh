#!/bin/bash
ps -Ao pid,cmd -u tedes |
awk '{pid=$1":"; $1=""; print pid substr($0,2)}' > task1_ans
sed -i "1s/.*/$(tail +2 task1_ans | wc -l)/" task1_ans
