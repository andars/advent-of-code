#!/usr/bin/env python3

count = 0
count2 = 0

def valid(a,b,c):
    if a + b > c and a + c > b and b + c > a:
        return True
    return False

def solve(line):
    global count
    lengths = [int(num) for num in line.strip().split(' ') if len(num) > 0]
    a = lengths[0]
    b = lengths[1]
    c = lengths[2]

    if valid(a,b,c):
        count += 1

def test(a, b, c):
    global count2
    if valid(a,b,c):
        count2+=1

with open('input.txt') as input:
    lines = [l for l in input]

    # Part 1
    for line in lines:
        solve(line)

    # Part 2
    groups = [[lines[k], lines[k+1], lines[k+2]] for k in range(0,len(lines)-2,3)]
    for g in groups:
        lengths = [
                [int(n) for n in length.strip().split(' ') if len(n) > 0]
                for length in g
                ]

        for i in range(3):
            test(lengths[0][i], lengths[1][i], lengths[2][i])

    print(count)
    print(count2)
