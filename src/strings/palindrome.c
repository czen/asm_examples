#include "stdio.h"
#include "string.h"

int palindrome(char* str) {
    int leftIndex = 0;
    int rightIndex = strlen(str) - 1;
    while (1) {
        // leftIndex++;
        // rightIndex--;
        // if (leftIndex > rightIndex) {
        //     break;
        // }
        if(str[leftIndex] == str[rightIndex]) {

        } else {
            return 0;
        }
        leftIndex++;
        rightIndex--;
        if (leftIndex >= rightIndex) {
            break;
        }

    }
    return 1;
}

int main(int agrc, char* argv[]) {
    char* str = "dd";
    printf("palindrome(%s)=%d\n", str, palindrome(str));
    return 0;
}
