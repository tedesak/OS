#!/bin/bash

N_MAX=6
REPEAT_CNT=3

touch .tmp

for ((N = 1; N <= $N_MAX; N++))
do
  sum=0
  for ((i = 0; i < $REPEAT_CNT; i++))
  do
    ./$3
    sudo time -f"%e" -ao .tmp ./$1 $2 $N
  done
  sum=$(cat .tmp | awk '{s+=$1}END{print s}')
  avg=$(awk -v x=$sum -v n=$REPEAT_CNT 'BEGIN { print x / n }')
  echo "$N $avg"
  >.tmp
done

sudo rm .tmp