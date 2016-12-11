#!/usr/bin/env ruby

require 'set'

filename = ARGV[0]

lines = File.readlines(filename)
goal = [17,61].to_set

bots = Hash.new
instrs = Hash.new
outputs = Hash.new

lines.each do |line|
  if line =~ /bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/
    instrs[$1] ||= Set.new
    instrs[$1].add [$2, $3, $4, $5]
  elsif line =~ /value (\d+) goes to bot (\d+)/
    bots[$2] ||= Set.new
    bots[$2].add($1.to_i)
  end
end

while true
  if bots.has_value?(goal)
    puts bots.key(goal)
  end

  ready, chips = bots.find { |k,v| v.length == 2 }
  break if not ready

  instrs[ready].each do |t1, d1, t2, d2|
    min, max = chips.minmax
    chips.clear

    bots[d1] ||= Set.new
    outputs[d1] ||= Set.new
    bots[d2] ||= Set.new
    outputs[d2] ||= Set.new

    if t1 == 'bot'
      bots[d1].add min
    else
      outputs[d1].add min
    end
    if t2 == 'bot'
      bots[d2].add max
    else
      outputs[d2].add max
    end
  end
end

p outputs['0'].min * outputs['1'].min * outputs['2'].min

