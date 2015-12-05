#include <stdio.h>

int main() {
    char c = ' ';

    int level = 0;
    while (scanf("%c", &c) > 0) {
        switch (c) {
        case '(':
            level++;
            break;
        case ')':
            level--;
            break;
        case '\n':
        case '\r':
            break;
        default:
            printf("Error! %c\n", c);
            return 1;
        }
    }
    printf("Level: %d\n", level);
}