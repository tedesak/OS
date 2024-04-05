#!/bin/bash

./task4_1.sh & pid1=$!
./task4_1.sh & pid2=$!
./task4_1.sh & pid3=$!

cpulimit -b -p $pid1 --limit 10

echo $pid1
echo $pid2
echo $pid3
