#!/bin/bash

for ((i = 2; i <= $2 + 1; i++))
do
  ./$1 $i &
done > /dev/null

temp=$(ps r | grep "./$1")
while [ -n "$temp" ]
do
	sleep 0.3
	temp=$(ps r | grep "./$1")
done