#!/usr/bin/env python3

def has_duplicate(s):
    last = ""
    for c in s:
       if c == last:
           return True
       last = c
    return False

def vowel_count(s):
    vowels = list(filter(lambda c: c in ['a','e','i','o','u'], s))
    return len(vowels)

def contains_illegal(s):
    return 'ab' in s or 'cd' in s or 'pq' in s or 'xy' in s

def is_nice(s):
    return has_duplicate(s) and (not contains_illegal(s)) and vowel_count(s) >= 3

def has_pair(s):
    for i in range(len(s)-1):
        for j in range(i+2,len(s)-1):
            if s[j:j+2] == s[i:i+2]:
                return True
    return False


def has_spaced_repeat(s):
    for i in range(len(s)):
        if i + 2 < len(s):
            if s[i] == s[i+2]:
                return True
    return False

def is_nice2(s):
    return has_spaced_repeat(s) and has_pair(s)

with open('inputs/day05.txt') as f:
    count = 0
    count2 = 0
    for line in f:
        if is_nice(line):
            count += 1
        if is_nice2(line):
            count2 += 1
    print(count)
    print(count2)

