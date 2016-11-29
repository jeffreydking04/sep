def insertion_sort(collection)
  sorted_collection = [collection.delete_at(0)]
  for val in collection
    sorted_collection_index = 0
    while sorted_collection_index < sorted_collection.length
      if val <= sorted_collection[sorted_collection_index]
        sorted_collection.insert(sorted_collection_index, val)
        break
      elsif sorted_collection_index == sorted_collection.length - 1
        sorted_collection.insert(sorted_collection_index + 1, val)
        break
      end
      sorted_collection_index += 1
    end
  end
  sorted_collection
end

def selection_sort(collection)
  length = collection.length
  for i in 0..length - 2
    min_index = i
    for j in (i + 1)...length
      if collection[j] < collection[min_index]
        min_index = j  
      end
    end
    tmp = collection[i]
    collection[i] = collection[min_index]
    collection[min_index] = tmp
  end
  collection
end

def bubble_sort(collection)
  n = collection.length
  begin
    swapped = false
    (n - 1).times do |i|
      if collection[i] > collection[i + 1]
        tmp = collection[i]
        collection[i] = collection[i + 1]
        collection[i + 1] = tmp
        swapped = true
      end
    end
  end until not swapped
  collection
end

def merge_sort(collection)
  if collection.length <= 1
    collection
  else
    mid = (collection.length / 2).floor
    left = merge_sort(collection[0..mid - 1])
    right = merge_sort(collection[mid..collection.length])
    merge(left, right)
  end
end

def merge(left, right)
  if left.empty?
    right
  elsif right.empty?
    left
  elsif left.first < right.first
    [left.first] + merge(left[1..left.length], right)
  else
    [right.first] + merge(left, right[1..right.length])
  end
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

def heap_sort(collection)
  heapify(collection)
  last_index = collection.size - 1
  while last_index != 0
    collection[0], collection[last_index] = collection[last_index], collection[0]
    last_index -= 1
    bubble_down(collection, 0, last_index)
  end
end

def heapify(collection)
  last_parent = (collection.size - 2) / 2
  last_parent.downto(0).each do |root|
    bubble_down(collection, root, collection.size - 1)
  end
end

def bubble_down(collection, root, last)
  child = root * 2 + 1
  while child <= last
    child += 1 if child + 1 <= last && collection[child + 1] > collection[child]
    if collection[child] > collection[root]
      collection[root], collection[child] = collection[child], collection[root]
      root = child
      child = root * 2 + 1
    else
      break
    end
  end
end

def bucket_sort(collection)
  return collection if collection.size == 0 || collection.size == 1
  min = collection.min
  max = collection.max
  divisor = (collection.size / 200).floor + 1  
  number_of_buckets = (max - min) / divisor
  buckets = []
  (0..number_of_buckets).each do |i|
    buckets[i] = []
  end
  (0...collection.size).each do |x|
    buckets[(collection[x] - min) / divisor] << collection[x]
  end
  (0..number_of_buckets).each do |z|
    buckets[z]= bucket_sort(buckets[z])
  end
  collection = []
  (0..number_of_buckets).each do |y|
    collection = collection + buckets[y]
  end
  collection
end

def jdk_merge_sort(collection)
  last = collection.size - 1
  return collection if last <= 0
  skip = 2
  while (skip / 2) < last + 1
    (0..last).step(skip).each do |i|
      right = i + skip / 2
      next if right > collection.size - 1
      pointer = i
      temp = right
      while pointer < i + skip / 2
        if temp < right && right <= last
          if collection[temp] > collection[right]
            collection[pointer], collection[right] = collection[right], collection[pointer]
            right += 1
          else
            larger = collection.delete_at(pointer)
            collection.insert(right - 1, larger)
            smaller = collection.delete_at(temp - 1)
            collection.insert(pointer, smaller)
          end
        elsif right > last
          while(collection[pointer] > collection[last])
            reinsert = collection.delete_at(pointer)
            collection << reinsert
          end
          pointer = last + 1
        else
          if collection[pointer] > collection[right]
            collection[pointer], collection[right] = collection[right], collection[pointer]
            right += 1  
          end
        end
        pointer += 1
      end
      while (pointer < i + skip && pointer <= last)
        break if right == i + skip || right > last
        break if right == pointer
        if collection[pointer] > collection[right]
          right_insert = collection.delete_at(right)
          collection.insert(pointer, right_insert)
          right += 1
        end
        pointer += 1
      end
    end
    skip *= 2      
  end
  collection
end

def jdk_insertion_sort(collection)
  return collection if collection.size < 2
  sorted_array = [collection.delete_at(0)]
  (0...collection.size).each do |i|
    sorted_size = sorted_array.size
    min = 0
    max = sorted_size
    element = collection[i]
    while min <= max
      mid1 = (min + max) / 2
      mid2 = mid1 + 1
      if sorted_array[mid2] && element >= sorted_array[mid1] && element <= sorted_array[mid2]
        sorted_array.insert(mid2, element)
        break
      elsif element < sorted_array[mid1] && mid1 == 0
        sorted_array.insert(0, element)
        break
      elsif (sorted_array[mid2] && element > sorted_array[mid2] && mid2 >= sorted_size - 1)  ||
            (!sorted_array[mid2] && element > sorted_array[mid1])
        sorted_array << element
        break
      elsif element < sorted_array[mid1]
        max = mid1
      else
        min = mid2 
      end
    end
  end
  sorted_array
end

require 'benchmark'

insertion_time = 0
selection_time = 0
bubble_time = 0
merge_time = 0
quick_time = 0
heap_time = 0
bucket_time = 0
jdk_merge_time = 0
jdk_insertion_time = 0
ruby_sort_time = 0

(1..100).each do
  array = (1..2).map { |x| x }
  array.shuffle!
  copy = array.map { |x| x }
  insertion_time += Benchmark.realtime {
    insertion_sort(copy)
  }
  copy = array.map { |x| x }
  selection_time += Benchmark.realtime {
    selection_sort(copy)
  }
  copy = array.map { |x| x }
  bubble_time += Benchmark.realtime {
    bubble_sort(copy)
  }
  copy = array.map { |x| x }
  merge_time += Benchmark.realtime {
    merge_sort(copy)
  }
  copy = array.map { |x| x }
  quick_time += Benchmark.realtime {
    quick_sort(copy, 0, copy.size - 1)
  }
  copy = array.map { |x| x }
  heap_time += Benchmark.realtime {
    heap_sort(copy)
  }
  copy = array.map { |x| x }
  bucket_time += Benchmark.realtime {
    bucket_sort(copy)
  }
  copy = array.map { |x| x }
  jdk_merge_time += Benchmark.realtime {
    jdk_merge_sort(copy)
  }
  copy = array.map { |x| x }
  jdk_insertion_time += Benchmark.realtime {
    jdk_insertion_sort(copy)
  }
  copy = array.map { |x| x }
  ruby_sort_time += Benchmark.realtime {
    copy.sort!
  }
end

puts "Insertion: #{insertion_time / 100}"
puts "Selection: #{selection_time / 100}"
puts "Bubble: #{bubble_time / 100}"
puts "Merge: #{merge_time / 100}"
puts "Quick: #{quick_time / 100}"
puts "Heap: #{heap_time / 100}"
puts "Bucket: #{bucket_time / 100}"
puts "jdk_merge: #{jdk_merge_time / 100}"
puts "jdk_insertion: #{jdk_insertion_time / 100}"
puts "ruby_sort: #{ruby_sort_time / 100}"
