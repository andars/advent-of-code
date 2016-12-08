#!/usr/bin/env ruby
filename = ARGV[0]

$screen = []

6.times do |i|
  $screen << [' '] * 50
end

def rect(a,b)
  b.times do |i|
    a.times do |j|
      $screen[i][j] = '#'
    end
  end
end

def rotate_row(row, shift)
  $screen[row] = $screen[row].rotate(-shift)
end

def rotate_col(col, shift)
  ns = $screen.transpose
  ns[col] = ns[col].rotate(-shift)
  $screen = ns.transpose
end

File.open(filename).each_line do |line|
  if line =~ /rect (\d*)x(\d*)/
    rect($1.to_i,$2.to_i)
  elsif line =~ /rotate row y=(\d*) by (\d*)/
    rotate_row($1.to_i,$2.to_i)
  elsif line =~ /rotate column x=(\d*) by (\d*)/
    rotate_col($1.to_i,$2.to_i)
  end
end

puts $screen.reduce(0) { |s, row|
  s + row.reduce(0) { |s2, cell|
    s2 + (cell == '#' ? 1 : 0)
  }
}

puts $screen.map(&:join)
