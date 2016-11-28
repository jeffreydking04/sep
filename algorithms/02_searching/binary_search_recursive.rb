# returns the index of a target element in a sorted collection using recursive binary search
def bin_rec(target, collection, min, max)
  return if min > max
  index = (min + max) / 2
  return index if collection[index] == target
  collection[index] < target ? min = index + 1 : max = index - 1
  bin_rec(target,collection, min, max)
end

array = []
(0...100).each do |x|
  array << x
end

require 'benchmark'

(0...100).each do |x|
  puts bin_rec(x, array, 0, array.size)
end