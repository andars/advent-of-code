#!/usr/bin/env ruby
disks = []

File.read(ARGV[0]).each_line do |line|
  if line =~ /Disc #(\d+) has (\d+) positions; at time=(\d+), it is at position (\d+)./
    disks << [$1.to_i, $2.to_i, $4.to_i]
  end
end

def solve(disks)
  t = 0
  while true
    s = disks.inject(0) { |n, d|
      pos = (d[2] + d[0] + t) % d[1]
      n + pos
    }
    return t if s == 0
    t += 1
  end
end

puts "Part 1: #{solve(disks)}"
disks << [disks.length+1, 11, 0]
puts "Part 2: #{solve(disks)}"
