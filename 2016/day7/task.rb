#!/usr/bin/env ruby
filename = ARGV[0]

def abba(seg)
  (seg.length).times do |i|
    fst = seg[i..i+1]
    if seg[i..i+3] == fst + fst.reverse and fst[0] != fst[1]
      return true
    end
  end
  return false
end

have_tls = 0
have_ssl = 0

File.open(filename).each_line do |line|
  s = line.split(/[\[,\]]/)

  abba, _ = s.reduce([false, 0]) do |(status, i), seg|
    [(status or (abba(seg) and i%2 == 0)), i+1]
  end
  abba_hypernet, _ = s.reduce([false, 0]) do |(status, i), seg|
    [(status or (abba(seg) and i%2 == 1)), i+1]
  end
  have_tls += 1 if abba and not abba_hypernet

  ssl = false
  s.each_with_index do |seg, i|
    seg.length.times do |j|
      a,b = seg[j], seg[j+1]
      if seg[j..j+2] == [a,b,a].join
        s[i+1..-1].each_with_index do |seg2, k|
          ssl = true if seg2.include?([b,a,b].join) and (i+k)%2 == i%2
        end
      end
    end
  end
  have_ssl += 1 if ssl
end

puts have_tls
puts have_ssl
