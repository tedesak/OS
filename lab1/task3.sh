#!/bin/bash 
while :
do
    read input
    case $input in
    1)
    nano;;
    2)
    vi;;
    3)
    links;;
    4)
    exit 0;;
    *)
    echo "invalid input" && exit 1;;
    esac
done