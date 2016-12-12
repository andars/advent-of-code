#!/usr/bin/env ruby

require 'pp'

filename = ARGV[0]
lines = File.readlines(filename)

instructions = lines.map do |line|
  if line =~ /cpy (-?\d+) (.)/
    [:cpyi, $1.to_i, $2.to_sym]
  elsif line =~ /cpy (.) (.)/
    [:cpy, $1.to_sym, $2.to_sym]
  elsif line =~ /inc (.)/
    [:inc, $1.to_sym]
  elsif line =~ /dec (.)/
    [:dec, $1.to_sym]
  elsif line =~ /jnz (-?\d+) (-?\d+)/
    [:jnzi, $1.to_i, $2.to_i]
  elsif line =~ /jnz (.) (-?\d+)/
    [:jnz, $1.to_sym, $2.to_i]
  else
    puts "Unknown: #{line}"
    [:err]
  end
end


def execute(regs, instructions)
  i = 0
  while i < instructions.length
    instr = instructions[i]
    op, a, b = instr

    if op == :cpyi
      regs[b] = a
    elsif op == :cpy
      regs[b] = regs[a]
    elsif op == :inc
      regs[a] += 1
    elsif op == :dec
      regs[a] -= 1
    elsif op == :jnzi
      i += b - 1 if a != 0
    elsif op == :jnz
      i += b - 1 if regs[a] != 0
    else
      puts "Error"
    end
    i += 1
  end
end

regs = Hash.new(0)
execute(regs, instructions)
p regs[:a]

regs = Hash.new(0)
regs[:c] = 1
execute(regs, instructions)
p regs[:a]
