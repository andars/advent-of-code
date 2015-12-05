#!/usr/bin/env ruby

total = 0

STDIN.each_line do |line|
  line.chomp!
  sizes = line.split('x').map(&:to_i)
  areas = sizes.zip(sizes.rotate).map { |a| a.reduce :* }
  wrapping = areas.reduce(&:+)*2 + areas.min

  total += wrapping
end

puts total
