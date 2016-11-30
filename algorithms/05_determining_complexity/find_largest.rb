def find_largest(collection)
 largest = collection[0]
 collection.length.times do |i|
   if collection[i] >= largest
     largest = collection[i]
   end
 end
 largest
end

array = (1..10).to_a
array.shuffle!
puts find_largest(array)