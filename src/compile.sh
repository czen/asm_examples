#!/bin/bash
as $1.s -o $1.o --gstabs+
ld $1.o -o $1
