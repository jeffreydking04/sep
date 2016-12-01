def find_largest(collection)
  largest = collection[0]
  collection.length.times do |i|
    if collection[i] >= largest
      largest = collection[i]
    end
  end
  largest
end

def find_largest_better(collection)
  largest = collection[0]
  collection_length = collection.length
  (0..collection_length/2).each do |i|
    left_element = collection[i]
    right_element = collection[collection_length - i - 1]
    larger = right_element > left_element ? right_element : left_element
    if larger > largest
      largest = larger
    end
  end
  largest
end

class MyHash
  def initialize
    @hash = Hash.new
  end
  def largest
    return @hash[:largest]
  end
  def insert(collection)
    collection.each do |item|
      if item.to_i > @hash[:largest].to_i
        @hash[:largest] = item
      end
      @hash[item] = item
    end
  end
end

require 'benchmark'

reg = 0
bet = 0
hash = 0

(0..100).each do
  array = 5.times.to_a
  array.shuffle!
  copy = array.map { |x| x }
  reg = reg + Benchmark.realtime {
    find_largest(copy)
  }
  copy = array.map { |x| x }
  bet = bet + Benchmark.realtime {
    find_largest_better(copy)
  }
  copy = array.map { |x| x }
  h = MyHash.new
  hash = hash + Benchmark.realtime {
    h.insert(copy)
  }
end

puts "Regular: #{reg / 100}"
puts "Better:  #{bet / 100}"
puts "Hash: #{hash / 100}"

# 500000 element arrays:

# Regular: 0.024138989479397424
# Better:  0.029807961721089668
# Hash: 0.25694278970797313

# 50000 element arrays:

# Regular: 0.0023917353810975327
# Better:  0.002950676309119444
# Hash: 0.016340735241537913

# 5000 element arrays:

# Regular: 0.00026895607967162503
# Better:  0.00032673181034624575
# Hash: 0.001308291910099797

# 500 element arrays:

# Regular: 3.629382874350995e-05
# Better:  4.6692301402799785e-05
# Hash: 0.00016227280168095603

# 50 element arrays:

# Regular: 4.876090388279408e-06
# Better:  6.152449350338429e-06
# Hash: 1.9096318283118308e-05

# 5 element arrays:

# Regular: 1.232351060025394e-06
# Better:  1.405270886607468e-06
# Hash: 2.434751077089459e-06
