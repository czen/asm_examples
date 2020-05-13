#!/bin/bash
gcc -no-pie -o $1 $1.s -g
./$1
echo $?
