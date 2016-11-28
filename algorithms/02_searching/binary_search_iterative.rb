# returns index of target element in a collection using iterative search
def binary_iterative(target, collection)
  min = 0
  max = collection.size - 1
  index = (min + max) / 2
  while (min <= max)
    return index if collection[index] == target
    collection[index] < target ? min = index + 1 : max = index - 1
    index = (min + max) / 2
  end
end

array = []
(0...100).each do |x|
  array << x
end

require 'benchmark'

(0...100).each do |x|
  puts binary_iterative(x, array)
end