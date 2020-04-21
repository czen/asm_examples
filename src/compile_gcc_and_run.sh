#!/bin/bash
gcc -no-pie -o $1 $1.s
./$1
echo $?
