#!/usr/bin/env python3

import sys
import operator

rf = {}
m = 0

ops = {
    '<': operator.lt,
    '>': operator.gt,
    '<=': operator.le,
    '>=': operator.ge,
    '==': operator.eq,
    '!=': operator.ne,
    'inc': operator.add,
    'dec': operator.sub,
}

with open(sys.argv[1]) as input:
    for line in input:
        words = line.split(' ')
        dst = words[0]
        pred = ops[words[5]](rf.get(words[4], 0), int(words[6]))

        if pred:
            rf[dst] = ops[words[1]](rf.get(dst, 0), int(words[2]))
        m = max(max(rf.values()), m)

    print(max(rf.values()))
    print(m)

