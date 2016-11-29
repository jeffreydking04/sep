def jdk_insertion_sort(collection)
  return collection if collection.size < 2
  sorted_array = [collection.delete_at(0)]

  # iterate over remaining elements
  (0...collection.size).each do |i|
#p sorted_array
    # store the current size of the sorted array
    sorted_size = sorted_array.size
    min = 0
    max = sorted_size
    element = collection[i]


    while min <= max
      mid1 = (min + max) / 2
      mid2 = mid1 + 1
#puts "element: #{element}"
#puts "mid1: #{mid1}"
#puts "mid2: #{mid2}"
#puts "sorted_size: #{sorted_size}"

      # if the element is between the elements at mid1 and mid2, insert at mid2
      if sorted_array[mid2] && element >= sorted_array[mid1] && element <= sorted_array[mid2]
        sorted_array.insert(mid2, element)
        break
      elsif element < sorted_array[mid1] && mid1 == 0
        sorted_array.insert(0, element)
        break
      elsif (sorted_array[mid2] && element > sorted_array[mid2] && mid2 >= sorted_size - 1)  ||
            (!sorted_array[mid2] && element > sorted_array[mid1])
#puts "in larger conditional"
        sorted_array << element
        break
      elsif element < sorted_array[mid1]
        max = mid1
      else
        min = mid2 
      end
#puts "min: #{min}"
#puts "max: #{max}"
#puts
    end
  end
  sorted_array
end


(1..10).each do
array = (1..100000).to_a

array.shuffle!

valid = true
(0...9999).each do |x|
  valid = false if array[x] > array[x+1]
end
puts valid

#p array

array = jdk_insertion_sort(array)

valid = true
(0...9999).each do |x|
  valid = false if array[x] > array[x+1]
end
puts valid

#p array
puts
end