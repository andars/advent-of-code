#!/usr/bin/env python3

import sys

insts = []

with open(sys.argv[1]) as input:
    for line in input:
        insts.append(int(line))


print(insts)

pc = 0
count = 0
while pc >= 0 and pc < len(insts):
    oldpc = pc
    inst = insts[pc]
    pc += inst
    if inst >= 3:
        insts[oldpc] -= 1
    else:
        insts[oldpc] += 1
    count += 1

print(count)
