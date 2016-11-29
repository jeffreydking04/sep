def jdk_merge_sort(collection)

  # store last index of collection
  last = collection.size - 1

  # return if collection is empty or is of size one
  return collection if last <= 0

  # when running merge sort the way it is most often shown written
  # the multiple recursions can cause stack problems
  # I figure the divide process and the recursion are not necessary
  # as the essentially the collection is already divided into 
  # individual cells because it is in an array.  The divide is already
  # done, so just merge in place.

  # none of the elements are sorted, so our sorted element size is 1
  # and we want to consider array blocks of a size that is double
  # our current sorted block size, then iterate over the array in 
  # those size steps, so we iniitially set our step (renamed skip 
  # because we use the STEP method in our loop) to 2
  skip = 2

  # we want to do one last sort after the skip has reached or eclipsed
  # the collection size, but none after that, so by dividing the skip
  # size by two we will loop through one last time to finalize, but then
  # when skip doubles again at the end of the iteration, then the loop will 
  # exit correctly
  while (skip / 2) < last + 1
    # we are interested in merging collections each of size skip
    (0..last).step(skip).each do |i|
      # we are interested in merging two portions of collection, each of size
      # skip / 2; the pointer will point at the index of the first portion; 
      # if we havee done the job correctly, then the first (skip/2) elements
      # will already be sorted, as will the second (skip/2 ( or fewer)) elements,
      # if any
      # so we right pointer to be at the start of the second set and we only 
      # need the current pointer(pointer) to look at the first set, because
      # it will be iterating through that set anyway
      right = i + skip / 2

      # there will cases in which there are fewer than SKIP elements left
      # in an iteration (at the end of the collection), so if the right index
      # is set to a point beyond the size of the collection, then there is no
      # second set to merge (and the first should be sorted already) and we can 
      # go to the next iteration, which is will really signal the exit of that
      # iteration of the while loop
      next if right > collection.size - 1

      # set the pointer to the beginning of the first sorted block
      pointer = i

      # this is where things get neat; if the current left element is greater
      # than the current right element, then we are going to swap the left and right
      # elements, but that means that the left elment is no longer sorted, so we
      # need to keep track of it and compare it first
      temp = right

      # we will do different things depending on whether the pointer is in the first 
      # sorted section or the second, so let us deal with the first section first
      while pointer < i + skip / 2
        # we have to anticipate that a swap has been made, which means that the element
        # of the first section that needs to be considered first will have been swapped
        # to the second section.  Fortunately we kept the temp pointer for this eventuality
        # and it needs to be considered first, but only if it is less than the current right
        # pointer, because if a swap was made, the right pointer was incremented, but the
        # temp pointer was not
        if temp < right && right <= last
#puts "temp: #{temp}; pointer: #{pointer}; right: #{right}; collection: #{collection}"
          # check if temp (which is just the next left element) is greater than right
          if collection[temp] > collection[right]
            # if it is, then right needs to go to the current pointer and the current pointer
            # element needs to replace right, in our faux temp array
            collection[pointer], collection[right] = collection[right], collection[pointer]

            # a right section element has been placed, so the pointer needs to reflect that
            right += 1
          else
            # the next element of the left section is less than or equal to the 
            # next element of the right section, but it has been moved to our faux
            # temp array, so we need to swap it back; this means that the next left
            # element will be moved to the end of temp array
            # the pointer will iterate at the end of the while loop and the temp 
            # pointer still points at the next left element, so the swap is the only
            # thing that needs to be accomplished
            larger = collection.delete_at(pointer)
            collection.insert(right - 1, larger)
            smaller = collection.delete_at(temp - 1)
            collection.insert(pointer, smaller)
          end

        # in the very special case where right section has been exhausted and the 
        # pointer is still in the left section (which can only happen at the end 
        # of the array), we need to delete the element at pointer and push it back
        # onto the end of the collection, keep doing this until the pointer element
        # is less than the last element, which indicates the end of the array is 
        # in the right order
        elsif right > last
          while(collection[pointer] > collection[last])
            reinsert = collection.delete_at(pointer)
            collection << reinsert
          end
          pointer = last + 1

        # this else only happens if no swap has been made (once a right element has been
        # placed, the temp array exists until all right elements are placed) 
        else
          # check relationship of next left and right elements
          if collection[pointer] > collection[right]
            # make the swap, increment right pointer, else the left element is the correct
            # element at that index and so do nothing
            collection[pointer], collection[right] = collection[right], collection[pointer]
            right += 1  
          end
        end
        # iterate the pointer
        pointer += 1
      end

      # now we get to the second phase, where we are left with only the temp and the 
      # rest of right, which is really what is left of left and what is left of right
      # while there are still right elements left, delete them and reinsert at the pointer
      # if they are less than the pointer element
      # we all have to make sure the pointer does not go beyond the end of the collection
      while (pointer < i + skip && pointer <= last)

        # if there are no more right elements, we can break out of the loop
        break if right == i + skip || right > last

        # break if there are no more left elements (if pointer has caught up with right
        # all left elements have been placed)
        break if right == pointer

        # else delete right and reinsert if left > right and increment right, else iterate
        if collection[pointer] > collection[right]
          right_insert = collection.delete_at(right)
          collection.insert(pointer, right_insert)
          right += 1
        end
        # iterate the pointer
        pointer += 1
      end
    end

    # iterate the step by multiplying by two because we have doubled the size of our
    # sorted sections  
    skip *= 2      
  end
  collection
end
