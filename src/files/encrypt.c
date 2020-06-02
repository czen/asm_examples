#include "stdio.h"
#include "stdlib.h"

int main(int argc, char* argv[]) {
    if (argc != 2) { 
        return -1;
    }
    int key = atoi(argv[1]);

    char nextChar = ' ';
    do {
        scanf("%c", &nextChar);
        printf("%c", nextChar ^ key);
    } while (nextChar != '0');
}
