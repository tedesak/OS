#!/bin/bash

N=22500000
K=30

for (( i=0; i<K; i++ ))
do
	./newmem.bash $N &
done

top -n 1 | head -37 | tail -30
