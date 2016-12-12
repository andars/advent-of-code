#!/usr/bin/env ruby

require 'set'
require 'pp'

filename = ARGV[0]
lines = File.readlines(filename)

floors = []
lines.each do |line|
  stuff = line.split('a ').map(&:chomp)
  generators = stuff.select { |s| s.include? 'generator' }
  chips = stuff.select { |s| s.include? 'microchip' }
  floor = []
  floor += generators.map do |gen|
    [:gen, gen.split(' ')[0].to_sym]
  end
  chips.each do |chip|
    floor << [:chip, chip.split('-')[0].to_sym]
  end
  floors << floor
end

count = floors.flatten(1).length
$seen = Hash.new

# Any state is uniquely characterized by the locations
# of the paired generator and chips. Essentially, the names
# don't matter
def groups(floors)
  elements = floors.flatten(1).transpose[1].uniq
  elements.map do |el|
    pair = []
    floors.each_with_index do |floor, i|
      match = floor.select { |item| item[1] == el and item[0] == :gen }
      pair << i unless match.empty?
      match = floor.select { |item| item[1] == el and item[0] == :chip }
      pair << i unless match.empty?
    end
    pair
  end.sort
end

# Determines whether this item distribution fries any chips
def invalid?(floors)
  floors.each do |floor|
    chips = floor.select { |item, type| item == :chip }
    gens = floor.select { |item, type| item == :gen }
    chips.each do |chip|
      if not gens.include?([:gen, chip[1]]) and gens.size > 0
        return true
      end
    end
  end
  return false
end

# All legal moves that make sense to make
# Conditions:
#   1. Legal
#   2. Haven't seen it (or an equivalent) state before
def adjacents(current, count, floors)
  moves = []
  combos = (1..2).map { |i|
    floors[current].combination(i).to_a
  }.flatten(1)

  [+1, -1].each do |delta|
    new_floor = current + delta
    next unless 0 <= new_floor and new_floor <= 3

    combos.sort_by! { |c| -delta*c.length }

    combos.each do |combo|
      next_floors = floors.clone
      next_floors[current] = (floors[current].to_set - combo.to_set).to_a
      next_floors[new_floor] = (floors[new_floor].to_set + combo.to_set).to_a
      next if invalid?(next_floors)

      move = [new_floor, count+1, next_floors]
      moves << move unless $seen[[new_floor, groups(next_floors)]]
      $seen[[new_floor, groups(next_floors)]] = true
    end
  end
  moves
end

# BFS on graph of possible moves
def search(init, goal)
  next_moves = []
  next_moves += adjacents(0, 0, init)

  $seen[[0, groups(init)]] = true

  move_count = 0
  while next_move = next_moves.shift
    floor, dist, items = next_move
    if dist > move_count
      puts "#{dist } moves, queue has #{next_moves.length + 1}"
      move_count = dist
    end

    if items[3].length == goal
      return dist
    end

    next_moves += adjacents(floor, dist, items)
  end
end

puts "Need #{search(floors, count)} moves"
exit unless filename == 'input.txt'
floors[0] += [[:gen, :elerium], [:chip, :elerium],
              [:gen, :dilithium], [:chip, :dilithium]]
puts "Need #{search(floors, count+4)} moves"

