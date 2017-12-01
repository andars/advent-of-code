#!/usr/bin/env ruby
filename = ARGV[0]

File.open(filename).each_line do |line|
  input = line.chomp.split('').map(&:to_i)

  sum = 0
  input.each_with_index do  |d, i|
    if d == input[(i + 1) % input.length]
      sum += d
    end
  end
  puts "Part 1: #{sum}"

  halfway = (input.length/2).round
  sum = 0
  input.each_with_index do |d, i|
    if d == input[(i + input.length + halfway) % input.length]
      sum +=d
    end
  end

  puts "Part 2: #{sum}"
end

