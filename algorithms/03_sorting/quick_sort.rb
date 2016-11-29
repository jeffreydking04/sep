# The max parameter is an index so call with collection.size - 1
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
