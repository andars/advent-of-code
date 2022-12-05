import sys

elves = []
calories = 0
for line in sys.stdin.readlines():
    line = line.strip()
    if line == '':
        elves += [calories]
        calories = 0
    else:
        calories += int(line)

elves += [calories]

print(elves)
print(sorted(elves)[-1])
print(sum(sorted(elves)[-3:]))
