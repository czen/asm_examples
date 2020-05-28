#include "stdio.h"

int factorial(int x) {
if0:    if (x==0) {
        return 1;
    }
if1:    if (x==1) {
        return 1;
    }
recurse:    return x*factorial(x-1);
}

int main(int argc, char* argv[]) {
callfactorial:    printf("factorial(4) = %d\n", factorial(4));
    return 0;
}
