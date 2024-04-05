#!/bin/bash 
man bash |
sed -E 's[^A-Za-z]+\:\g' |
tr 'A-Z' 'a-z' I
tr ':' '\n' |
egrep '.{4}' |
sort |
uniq -c |
sort -k1 -n -r | 
head -3 |
awk '{print $2}'
