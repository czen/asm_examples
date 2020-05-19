FROM gitpod/workspace-full

USER root
# https://www.geeksforgeeks.org/compile-32-bit-program-64-bit-gcc-c-c/
RUN apt-get update && apt-get install -y gcc-multilib && apt-get install -y g++-multilib

# add your tools here ...
