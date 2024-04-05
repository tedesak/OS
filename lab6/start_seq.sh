#!/bin/bash

for ((i = 2; i <= $2 + 1; i++))
do
  ./$1 $i
done > /dev/null
