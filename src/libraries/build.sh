#!/bin/bash
as helloworld-lib.s -o helloworld-lib.o
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o helloworld-lib helloworld-lib.o -lc
