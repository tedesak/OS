#!/bin/bash
ans=""
read str
while [[ (-z $str) || $str != "q" ]] #because empty strings can be in input
do
    ans+=$str
    read str
done
echo $ans
