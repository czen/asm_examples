#!/bin/bash
g++ -S -fverbose-asm -g -O2 $1.c
as -alhnd $1.s > $1.lst
