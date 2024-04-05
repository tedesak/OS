#!/bin/bash
x=2
while true
do
x=$(expr "$x" + "$x")
done
