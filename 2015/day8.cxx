#include <iostream>
#include <algorithm>
#include <string>

using std::cin;
using std::cout;
using std::endl;

int main() {
    std::string line;
    int total_code = 0;
    int total_mem = 0;
    int total_enc = 0;

    while (cin >> line) {
        int code = 0;
        int mem = -2;
        int enc = 2;

        bool is_escaped = false;
        for (int i = 0; i<line.length(); i++) {
            code++;
            if (line[i] == '\\' && !is_escaped) {
                is_escaped = true;
            } else if (is_escaped) {
                if (line[i] == 'x') {
                    i += 2;
                    code += 2;
                }
                mem++;
                is_escaped = false;
            } else {
                mem++;
            }

            if (line[i] == '\"') {
                enc++;
            } else if (line[i] == '\\') {
                enc++;
            }
        }

        total_code += code;
        total_mem += mem;
        total_enc += code + enc;
    } 
    cout << (total_code - total_mem) << endl;
    cout << (total_enc - total_code) << endl;
}
