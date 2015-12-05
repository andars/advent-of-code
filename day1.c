#include <stdio.h>

int main() {
    char c = ' ';

    int level = 0;
    int basement_entry = -1;
    int position = 1;
    
    while (scanf("%c", &c) > 0) {
        switch (c) {
        case '(':
            level++;
            break;
        case ')':
            level--;
            if (level < 0 && basement_entry < 0) {
                basement_entry = position;
            }
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
    printf("Basement Entry Position: %d\n", basement_entry);
}