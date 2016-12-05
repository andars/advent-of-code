#!/usr/bin/env ruby

filename = ARGV[0]

require 'digest'

solution = 0

i = 0
id = gets.chomp
puts id
password = []
found = []

while password.length < 8
  result = Digest::MD5.hexdigest(id + i.to_s)
  pos = result[5].to_i(16)
  valid = result.start_with?('00000')
  if valid and pos <= 7 and not found[pos]
    p result
    found[pos] = true
    password << [pos, result[6]]
    p password
  end
  i += 1
end

p password.sort_by{ |x| x[0] }.map{ |x| x[1] }.join
