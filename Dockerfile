FROM gitpod/workspace-full

# https://www.geeksforgeeks.org/compile-32-bit-program-64-bit-gcc-c-c/
RUN apt-get update && apt-get install gcc-multilib && apt-get install g++-multilib

# add your tools here ...
