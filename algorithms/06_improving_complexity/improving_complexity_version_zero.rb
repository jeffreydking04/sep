# This method takes n arrays as input and combine them in sorted ascending  order
def working_sort(*arrays)
  combined_array = []
  arrays.each do |array|
    array.each do |value|
      combined_array << value
    end
  end
  sorted_array = [combined_array.delete_at(combined_array.length-1)]
  for val in combined_array
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
  end
  # Return the sorted array
  sorted_array
end

require 'benchmark'

time = 0

100.times do
  a1 = 10.times.to_a
  a1.shuffle!
  a2 = (10...20).to_a
  a2.shuffle!
  a3 = (20...30).to_a
  a3.shuffle!

  time = time + Benchmark.realtime {
    a1 = working_sort(a1, a2, a3)
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
    a1 = working_sort(a1, a2, a3)
  }
end
puts "3 1000  element arrays, well distributed, 100 times, average: #{time / 100}"