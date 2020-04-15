#!/bin/bash
as $1.s -o $1.o
#ld $1.o -o $1
gcc -o $1 -no-pie -nostartfiles $1.o
./$1
echo $?
