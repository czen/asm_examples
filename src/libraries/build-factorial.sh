#!/bin/bash
as factorial-lib.s -o factorial-lib.o
ld -shared factorial-lib.o -o libfactorial.so
as factorial-main.s -o factorial-main.o
ld -L . -dynamic-linker /lib/ld-linux-x86-64.so.2 -o factorial-main -lfactorial factorial-main.o
