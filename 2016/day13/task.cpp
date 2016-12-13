#include <cstdio>
#include <bitset>
#include <queue>
#include <map>

int goal_x = 31;
int goal_y = 39;
int input = 1352;

bool is_wall(int x, int y) {
    int t = x*x + 3*x + 2*x*y + y + y*y + input;
    std::bitset<64> b(t);
    return b.count() % 2 == 1;
}

void solve(int ix, int iy) {
    std::queue<std::tuple<int, int, int>> q;
    std::map<std::pair<int, int>, bool> seen;
    int delta[][2] = {
        { 1, 0},
        {-1, 0},
        { 0,-1},
        { 0, 1},
    };
    int pt1 = -1;
    int pt2 = 0;
    int limit = 50;
    int d, x, y;

    q.emplace(0, ix, iy);
    seen.emplace(std::make_pair(ix,iy), true);

    while (!q.empty()) {
        std::tie(d,x,y) = q.front();
        q.pop();

        pt1 = std::max(pt1, d);
        if (d <= limit) pt2++;

        if (x == goal_x && y == goal_y) {
            break;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + delta[i][0];
            int ny = y + delta[i][1];
            auto p = std::make_pair(nx,ny);
            if (nx < 0 || ny < 0 || is_wall(nx,ny) || seen.count(p)) {
                continue;
            }
            seen.emplace(p, true);
            q.emplace(d+1, nx, ny);
        }
    }
    printf("Part 1: %d\n", pt1);
    printf("Part 2: %d\n", pt2);
    printf("Examined %lu total nodes\n", seen.size());
}

int main() {
    solve(1,1);
}
