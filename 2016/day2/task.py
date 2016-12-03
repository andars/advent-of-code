#!/usr/bin/env python

def coords_to_num(x,y):
    return 3*y + x + 1

center = [1,3,7,11,13]

def coords_to_num2(x,y):
    return center[y+2] + x

def valid(x,y):
    return 0 <= x and x <= 2 and 0 <= y and y <= 2

def valid2(x,y):
    return abs(x) + abs(y) <= 2

moves = {
    'U': [0,-1],
    'D': [0,1],
    'L': [-1,0],
    'R': [1,0],
}

def next_coords(x, y, move):
    nx,ny = map(sum,zip((x,y),moves[move]))
    return [nx,ny] if valid(nx,ny) else [x,y]

def next_coords2(x, y, move):
    nx,ny = map(sum, zip((x,y), moves[move]))
    return [nx,ny] if valid2(nx,ny) else [x,y]

def solve(line, ix, iy):
    directives = list(line.strip())
    x,y = ix,iy
    for move in directives:
        x,y = next_coords(x,y,move)
    return [x,y]

def solve2(line, ix, iy):
    directives = list(line.strip())
    x,y = ix,iy
    for move in directives:
        x,y = next_coords2(x,y,move)
    return [x,y]

with open('input.txt') as input:
    x = 1
    y = 1
    part1 = []
    for line in input:
        x,y = solve(line,x,y)
        part1.append(str(coords_to_num(x,y)))
    print(''.join(part1))

with open('input.txt') as input:
    x = -2
    y = 0
    part2 = []
    for line in input:
        x,y = solve2(line,x,y)
        part2.append('{:x}'.format(coords_to_num2(x,y)).upper())
    print(''.join(part2))
