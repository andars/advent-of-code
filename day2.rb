#!/usr/bin/env ruby

total = 0
total_ribbon = 0

STDIN.each_line do |line|
  line.chomp!
  sizes = line.split('x').map(&:to_i)
  areas = sizes.zip(sizes.rotate).map { |a| a.reduce :* }
  wrapping = areas.reduce(&:+)*2 + areas.min
  sizes = sizes.sort
  ribbon = 2*(sizes[0] + sizes[1]) + sizes.reduce(:*)

  total += wrapping
  total_ribbon += ribbon
end

puts "Wrapping paper: #{total}"
puts "Ribbon: #{total_ribbon}"
