#!/usr/bin/env python3

def has_duplicate(s):
    last = ""
    for c in s:
       if c == last:
           return True
       last = c
    return False

def vowel_count(s):
    vowels = filter(lambda c: c in ['a','e','i','o','u'], s)
    return len(vowels)

def contains_illegal(s):
    return 'ab' in s or 'cd' in s or 'pq' in s or 'xy' in s

def is_nice(s):
    return has_duplicate(s) and (not contains_illegal(s)) and vowel_count(s) >= 3

with open('inputs/day05.txt') as f:
    count = 0
    for line in f:
        if is_nice(line):
            count += 1
    print(count)


