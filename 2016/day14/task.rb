#!/usr/bin/env ruby
require 'digest'

salt = 'ngcjuoqr'
puts salt

i = 0
possibles = []
keys = []

while keys.length < 64 or i <= keys[63][0]+1000
  pkey = salt + i.to_s
  h = Digest::MD5.hexdigest(pkey)

  2016.times do |i|
    h = Digest::MD5.hexdigest(h)
  end

  curr = ''
  count = 0
  cps = []
  found = false

  h.chars.each do |c|
    if curr == c
      count += 1
      if count == 3 and not found
        found = true
        cps << [i, c]
      elsif count == 5
        t, possibles = possibles.partition { |p| p[1] == c  }
        keys += t.select{ |pk| i - pk[0] <= 1000 }
      end
    else
      count = 1
      curr = c
    end
  end
  possibles += cps

  i += 1
end

keys = keys.sort_by{|k| k[0] }[0..63]
p keys[-1]
