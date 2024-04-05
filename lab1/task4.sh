#!/bin/bash
if [[ "$(pwd)" =~ ^$HOME ]] 
then
    pwd && exit 0
else
    echo "expected: launch from home dir" && exit 1 
fi
