#include "stdio.h"
#include "string.h"

int palindrome(char* str) {
    int leftIndex = 0;
    int rightIndex = strlen(str) - 1;
    while (1) {
        if(str[leftIndex] == str[rightIndex]) {

        } else {
            return 0;
        }
        if (str[leftIndex] == ' ') {
            while(leftIndex <= rightIndex && str[leftIndex] == ' ') {
                leftIndex++;
            }
        } else {
            leftIndex++;
        }
        if (str[rightIndex] == ' ') {
            while(rightIndex >= leftIndex && str[rightIndex] == ' ') {
                rightIndex--;
            }
        } else {
            rightIndex--;
        }
        if (leftIndex > rightIndex) {
            break;
        }

    }
    return 1;
}

int main(int agrc, char* argv[]) {
    char* str = " ro t  or";
    printf("palindrome(%s)=%d\n", str, palindrome(str));
    return 0;
}
