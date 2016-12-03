#!/usr/bin/env python

def coords_to_num1(x,y):
    return 3*y + x + 1

row_center = [1,3,7,11,13]

def coords_to_num2(x,y):
    return row_center[y+2] + x

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

def next_coords1(x, y, move):
    nx,ny = map(sum,zip((x,y),moves[move]))
    return [nx,ny] if valid(nx,ny) else [x,y]

def next_coords2(x, y, move):
    nx,ny = map(sum, zip((x,y), moves[move]))
    return [nx,ny] if valid2(nx,ny) else [x,y]

next_coords = [next_coords1, next_coords2]
coords_to_num  = [coords_to_num1, coords_to_num2]

def solve(line, ix, iy, part):
    directives = list(line.strip())
    x,y = ix,iy
    for move in directives:
        x,y = next_coords[part](x,y,move)
    return x, y, coords_to_num[part](x,y)

with open('input.txt') as input:
    x1 = 1
    y1 = 1
    x2 = -2
    y2 = 0
    part1 = []
    part2 = []
    for line in input:
        x1,y1, digit1 = solve(line,x1,y1,0)
        x2,y2, digit2 = solve(line,x2,y2,1)
        part1.append(str(digit1))
        part2.append('{:x}'.format(digit2).upper())
    print(''.join(part1))
    print(''.join(part2))

