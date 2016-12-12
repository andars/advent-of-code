#!/usr/bin/env ruby
filename = ARGV[0]
sum = 0

def decode(name, shift)
  name.map { |x|
    ((((x.ord - 'a'.ord) + shift) % 26) + 'a'.ord).chr
  }.join
end

File.open(filename).each_line do |line|
  info = line.chomp.split('-')
  tmp = info[-1]
  name = info[0..-2].join.split('')
  id, checksum = tmp.split('[')
  id = id.to_i
  checksum = checksum[0..-2]
  freq = name.reduce(Hash.new(0)) { |h,v| h[v] += 1; h }
  top = name.sort_by { |n|
    [-freq[n], n]
  }.uniq

  chk = top[0..4].join
  if chk == checksum
    sum += id
    puts decode(name, id), id
  end
end

puts "SUM: #{sum}"

