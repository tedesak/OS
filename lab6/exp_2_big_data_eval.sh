#!/bin/bash

ind=$(($1 - 2))
DATA_DIR=exp_2_dataset
DATA_PATH=$DATA_DIR/"data_$ind"

cat $DATA_PATH |
while read val
do
  if [[ $val == "END" ]]
  then
    break
  fi
  val=$((val * 2))
  echo $val
done >> $DATA_PATH
