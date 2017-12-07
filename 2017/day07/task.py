#!/usr/bin/env python3

import sys
from collections import Counter

progs = set()
held_progs = set()
holding = {}
weight = {}
sums = {}

with open(sys.argv[1]) as input:
    for line in input:
        els = line.split(' ')
        prog = els[0]
        progs.add(prog)
        if len(els) > 2:
            weight[prog] = int(els[1][1:-1])
            holding[prog] = [h[0:-1] for h in els[3:]]
            held_progs.update(holding[prog])
        else:
            sums[prog] = int(els[1][1:-2])

    print("Part 1: ", progs - held_progs)

    quit = False
    while not quit:
        for p in progs:
            if p in holding and all([(c in sums) for c in holding[p]]):
                above = [sums[c] for c in holding[p]]
                k = Counter(above)
                cs = k.most_common()
                if len(cs) > 1:
                    ideal, actual = cs[0][0], cs[-1][0]
                    pr = holding[p][above.index(actual)]
                    print("Part 2: ", ideal - (actual - weight[pr]))
                    quit = True
                else:
                    sums[p] = weight[p] + sum(k.elements())

