def heap_sort(collection)
  # heapify the collection, which guarantees the highest value will be
  # at collection[0]; it is only called once, because bubble_down will do the 
  # work from this point forward
  heapify(collection)

  # keep track of the last index that is still unsorted; at this point it is the
  # last index in the collection
  last_index = collection.size - 1

  # while last_index != 0, keep swapping and bubbling down
  while last_index != 0
    collection[0], collection[last_index] = collection[last_index], collection[0]
    last_index -= 1
    bubble_down(collection, 0, last_index)
  end
end

# partially sorts an array, ensuring max value is at top, by bubbling down all parents
# we ensure all children have the chance to bubble up, we start with the index of the last
# parent and count down
def heapify(collection)
  # this formula gets the index of the last parent
  last_parent = (collection.size - 2) / 2

  # count down
  last_parent.downto(0).each do |root|
    # bubble_down works with the last possible index number, so subtract 1 from size
    # we are heapifying the whole array, so the last index is always the last index,
    # unlike when we bubble down a partially sorted collection
    bubble_down(collection, root, collection.size - 1)
  end
end

# compares a node with its children, and swaps with its largest child if it smaller than child,
# then does it again as long as child is not past the last index
def bubble_down(collection, root, last)
  # find the index of the node's first child
  child = root * 2 + 1

  # make sure the child is not out of bounds
  while child <= last
    # if the second child (at index child + 1), is inbounds and greater than child
    # then assign second child to child
    child += 1 if child + 1 <= last && collection[child + 1] > collection[child]

    # if designated child node is greater than node, swap, else break because the heap is valid
    # if swap is made, set root index to child index because that indexes children need to be
    # checked; assign child its new index
    if collection[child] > collection[root]
      collection[root], collection[child] = collection[child], collection[root]
      root = child
      child = root * 2 + 1
    else
      break
    end
  end
end

# I created and array from 1 to 100_000, shuffled it, and heap_sorted it, then checked it for 
# validity and it was valid 5 straight times.  Highly unlikely that it is defective.
