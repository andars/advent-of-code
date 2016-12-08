#!/usr/bin/env ruby
filename = ARGV[0]

$screen = []

6.times do |i|
  row = []
  50.times do |j|
    row << 0
  end
  $screen << row
end

def rect(a,b)
  b.times do |i|
    a.times do |j|
      $screen[i][j] = 1
    end
  end
end

def rotate_row(r,shift)
  row = $screen[r]
  $screen[r] = row[-shift..-1] + row[0..-shift-1]
end

def rotate_col(c, shift)
  ns = $screen.transpose
  col = ns[c]
  ns[c] = col[-shift..-1] + col[0..-shift-1]
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
    s2 + cell
  }
}

puts $screen.map { |row|
  row.map {|cell|
    cell == 1 ? "#" : " "
  }.join
}


