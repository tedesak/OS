#!/bin/bash

REPEAT_CNT=4

./"$1" > .repeat

for ((i = 1; i < $REPEAT_CNT; i++))
do
  ./"$1" | awk '{print $2}' > .repeat.tmp
  if [ -f .repeat ]
  then
    paste .repeat .repeat.tmp | awk '{print $1, $2 + $3}' > q
    mv q .repeat
  else
    mv .repeat.tmp .repeat
  fi
done

cat .repeat | awk -v rep_cnt=$REPEAT_CNT '{print $1, $2 / rep_cnt}'
