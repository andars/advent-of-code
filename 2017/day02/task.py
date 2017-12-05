#!/usr/bin/env python3

import sys
import math


ss = []
cs = 0

with open(sys.argv[1]) as input:
    for line in input:
        vals = [int(v) for v in line.split('\t')]
        cs += max(vals) - min(vals)
print(cs)

s = 0

def evenly_divides(a, b):
    return (a/b == round(a/b))

with open(sys.argv[1]) as input:
    for line in input:
        vals = [int(v) for v in line.split('\t')]

        for i in range(len(vals)):
            for j in range(len(vals)):
                if i != j:
                    if evenly_divides(vals[i], vals[j]):
                        s += vals[i]/vals[j]

print(round(s))

