#!/bin/bash
ps a |
awk '/ \/sbin\/.*/{print $1}' > task2_ans
