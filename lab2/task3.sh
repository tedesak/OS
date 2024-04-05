#!/bin/bash
ps -Ao pid --sort=start |
tr -d " " |
tail -1
