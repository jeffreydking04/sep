# This method takes n arrays as input and combine them in sorted ascending  order
def quick_multi_array_sort(*arrays)
  combined_array = []
  arrays.each do |array|
    combined_array = combined_array + array
  end

  sorted_array = quick_sort(combined_array, 0, combined_array.size - 1)
end

def quick_sort(collection, min, max)
  return collection if min >= max
  pivot = min
  ((min + 1)..max).each do |i|
    if collection[i] < collection[pivot]
      collection[pivot], collection[i] = collection[i], collection[pivot]
      collection[i], collection[pivot + 1] = collection[pivot+1], collection[i]
      pivot += 1
    end
  end
  quick_sort(collection, min, pivot - 1)
  quick_sort(collection, pivot + 1, max)
end

#require 'benchmark'
#
#time = 0
#
#a1 = 10.times.to_a
#a1.shuffle!
#a2 = (10...20).to_a
#a2.shuffle!
#a3 = (20...30).to_a
#a3.shuffle!
#a1 = quick_multi_array_sort(a1, a2, a3)
#p a1
#
#100.times do
#  a1 = 10.times.to_a
#  a1.shuffle!
#  a2 = (10...20).to_a
#  a2.shuffle!
#  a3 = (20...30).to_a
#  a3.shuffle!
#
#  time = time + Benchmark.realtime {
#    a1 = quick_multi_array_sort(a1, a2, a3)
#  }
#end
#puts "3 10  element arrays, well distributed, 100 times, average: #{time / 100}"
#
#100.times do
#  a1 = 1000.times.to_a
#  a1.shuffle!
#  a2 = (1000...2000).to_a
#  a2.shuffle!
#  a3 = (2000...3000).to_a
#  a3.shuffle!
#
#  time = time + Benchmark.realtime {
#    a1 = quick_multi_array_sort(a1, a2, a3)
#  }
#end
#puts "3 1000  element arrays, well distributed, 100 times, average: #{time / 100}"