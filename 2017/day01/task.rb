#!/usr/bin/env ruby
filename = ARGV[0]
sum = 0

File.open(filename).each_line do |line|
  # info = line.chomp.split('-')
  # tmp = info[-1]
  # name = info[0..-2].join.split('')
  # id, checksum = tmp.split('[')
  # id = id.to_i
  # checksum = checksum[0..-2]
  # freq = name.reduce(Hash.new(0)) { |h,v| h[v] += 1; h }
  # top = name.sort_by { |n|
  #   [-freq[n], n]
  # }.uniq

  # chk = top[0..4].join
  # if chk == checksum
  #   sum += id
  #   puts decode(name, id), id
  # end
  input = line.chomp.split('').map(&:to_i)

  sum = 0

  input.each_with_index do  |d, i|
    if (i < input.length-1 and d == input[i+1])
      sum += d
    elsif i == input.length-1 and  d == input[0]
      sum += d
    end
  end

  puts "SUM: #{sum}"

  halfway = (input.length/2).round

  sum = 0
  input.each_with_index do |d, i|
    if d == input[(i + input.length + halfway) % input.length]
      sum +=d
    end
  end




  puts "SUM: #{sum}"
end


