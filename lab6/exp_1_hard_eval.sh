#!/bin/bash

#in this script eval (x ^ (2 ^ N)) % MODULE

N=250000
MODULE=1000000007
x=$1

for ((i = 0; i < $N; i++))
do
  x=$((x * x % MODULE))
done

echo $x