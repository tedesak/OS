#!/bin/bash

#250 KB
SIZE=50000
N=6

for (( nxt=0; nxt < $N; nxt++ ))
do
    for (( i=0; i < SIZE; i++ ))
    do
        echo $RANDOM
    done > /home/tedes/lab6/exp_2_dataset/"data_$nxt"

    echo "END" >> /home/tedes/lab6/exp_2_dataset/"data_$nxt"
done