#!/usr/bin/env ruby
filename = ARGV[0]

positions = []
10.times do |i|
  positions << Hash.new(0)
end

File.open(filename).each_line do |line|
  chars = line.split('')
  chars.each_with_index do |c, i|
    positions[i][c] += 1
  end
end

puts "Part 1:"
puts positions.map { |pos|
  k,_ = pos.max_by{|k,v| v}
  k
}.join

puts "Part 2:"
puts positions.map { |pos|
  k,_ = pos.min_by{|k,v| v}
  k
}.join
