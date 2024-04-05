#!/bin/bash
ans=""
for file in $(find /etc -type f)
do
    grep -aoE '([a-zA-Z0-9_\-\.\+]+)@([a-zA-Z0-9_\-\.\+]+)\.([a-zA-Z]+)' ${file} 
    #E поддержка сложных regexp; а - скип бинарных файлов; о — вывод только совпадений
done |
sort |
uniq |
(
while read str
do
    ans+=,$str
done
echo $ans
) |
awk '{print substr($0, 2)}' > emails.lst
