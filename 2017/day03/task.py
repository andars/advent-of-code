#!/usr/bin/env python3

import sys
import math

index = int(sys.argv[1])

def dist(i):
    shell = math.ceil((math.sqrt(i) - 1)/2)
    shell_max = (2*shell + 1)**2
    side_len = 2*shell + 1

    dx = -1
    dy = 0
    px = shell
    py = -shell
    steps = int(shell_max - i)

    for s in range(0,steps):
        px += dx
        py += dy
        if (s + 1) % (side_len - 1) == 0:
            dx, dy = dy, -dx

    print(px, py)
    return abs(px) + abs(py)

print(dist(index))




