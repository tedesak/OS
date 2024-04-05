#!/bin/bash
if ! test -f "task4_ans"
then
./task4.sh
fi

cat task4_ans |
awk -F '[:=]' '
BEGIN{
sum="0"
cnt="0"
pred="0"
}
{
if (pred < $4)
{
	if (pred > "0") {
	print "Average_Running_Children_of_ParentID=" pred " is " sum/cnt
	}
	pred=$4
	sum="0"
	cnt="0"
}
sum+=$6
cnt+="1"
print $0
}
END{
print "Average_Running_Children_of_ParentID=" pred " is " sum/cnt
}' > task5_ans
