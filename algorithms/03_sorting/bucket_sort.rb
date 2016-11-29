def bucket_sort(collection)
  # We return the collection if it of size 0 or 1
  return collection if collection.size == 0 || collection.size == 1

  # We use O(n) twice to find min and max
  min = collection.min
  max = collection.max


  # Then we figure out how many buckets we need.  I am using buckets that hold 5 intergers
  # We divide the range by 5 to get the buckets needed.
  divisor = (collection.size / 5).floor + 1  
  number_of_buckets = (max - min) / divisor

  buckets = []
  (0..number_of_buckets).each do |i|
    buckets[i] = []
  end
  (0...collection.size).each do |x|
    buckets[(collection[x] - min) / divisor] << collection[x]
  end

  # recursively call bucket_sort on the buckets
  (0..number_of_buckets).each do |z|
    #set each bucket to its the returned sorted bucket
    buckets[z]= bucket_sort(buckets[z])
  end

  # concatenate the buckets back togehter
  collection = []
  (0..number_of_buckets).each do |y|
    collection = collection + buckets[y]
  end
  collection
end
