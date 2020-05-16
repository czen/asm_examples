#include <cstdio>

#define n 10 

int binarySearch(int array[], int l, int r, int x) {
    if (r >= l) {
        int mid = l + (r-1) / 2;
        if (array[mid] == x) {
            return 1;
        } else if (array[mid] > x) {
            return binarySearch(array, l, mid - 1, x);
        } else {
            return binarySearch(array, mid + 1, r, x);
        }
    } else {
        return 0;
    }
}

int main(int argc, char* argv[]) {
    int array[n] = {3,5,8,23,34,56,59,60,78,90};
    return binarySearch(array, 0, n, 24);
}

