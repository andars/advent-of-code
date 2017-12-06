#!/usr/bin/env python3

import sys

seen = {}

with open(sys.argv[1]) as input:
    line = input.readline()
    membanks = [int(c) for c in line.split('\t')]
    print(membanks)
    count = 0

    while True:
        mi = membanks.index(max(membanks))
        num = membanks[mi]
        membanks[mi] = 0
        for i in range(num):
            membanks[(mi + i + 1) % len(membanks)] += 1
        count += 1

        h = str(membanks)
        seen_index = seen.get(h, None)

        if seen_index != None:
            loop_size = count - seen_index
            break
        else:
            seen[h] = count

    print("Part 1: ", count)
    print("Part 2: ", loop_size)

