#!/bin/bash

echo "*/5 * * * $(date +%a) /home/tedes/lab3/task1.sh" | crontab
