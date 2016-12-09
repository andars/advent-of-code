#!/usr/bin/env ruby
filename = ARGV[0]

orig = gets.chomp.chars
line = orig.clone

olen = 0
while line.length > 0
  if line.shift == '('
    len, reps = line.shift(line.index(')')+1).join.split('x').map(&:to_i)
    olen += len * reps
    line.shift(len)
  else
    olen += 1
  end
end
puts olen

line = orig.clone
def dlen(s)
  olen = 0
  while s.length > 0
    if s.shift == '('
      len, reps = s.shift(s.index(')')+1).join.split('x').map(&:to_i)
      olen += dlen(s[0..len-1]) * reps
      s.shift(len)
    else
      olen += 1
    end
  end
  olen
end
puts dlen(line)
