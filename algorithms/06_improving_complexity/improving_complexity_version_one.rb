# This method takes n arrays as input and combine them in sorted ascending  order
def optimized_sort(*arrays)
  combined_array = []
  arrays.each do |array|
    combined_array = combined_array + array
  end
  sorted_array = [combined_array[0]]
  j = 1
  while j < combined_array.length
    val = combined_array[j]
    i = 0
    while i < sorted_array.length
      if val <= sorted_array[i]
        sorted_array.insert(i, val)
        break
      elsif i == sorted_array.length - 1
        sorted_array << val
        break
      end
      i+=1
    end
    j+=1
  end
  # Return the sorted array
  sorted_array
end

require 'benchmark'

time = 0

#a1 = 10.times.to_a
#a1.shuffle!
#a2 = (10...20).to_a
#a2.shuffle!
#a3 = (20...30).to_a
#a3.shuffle!
#a1 = working_sort(a1, a2, a3)
#p a1

100.times do
  a1 = 10.times.to_a
  a1.shuffle!
  a2 = (10...20).to_a
  a2.shuffle!
  a3 = (20...30).to_a
  a3.shuffle!

  time = time + Benchmark.realtime {
    a1 = optimized_sort(a1, a2, a3)
  }
end
puts "3 10  element arrays, well distributed, 100 times, average: #{time / 100}"

100.times do
  a1 = 1000.times.to_a
  a1.shuffle!
  a2 = (1000...2000).to_a
  a2.shuffle!
  a3 = (2000...3000).to_a
  a3.shuffle!

  time = time + Benchmark.realtime {
    a1 = optimized_sort(a1, a2, a3)
  }
end
puts "3 1000  element arrays, well distributed, 100 times, average: #{time / 100}"