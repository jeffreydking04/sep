def find_path(cities_hash, start_city)
  # return if the city is not  in the hash or not present
  return "Invalid start city!" if !start_city || !cities_hash[start_city]

  # copy the cities_hash
  cities_copy = cities_hash.clone

  # initialize current city, coordinates, path, and do first delete from copy
  current_city = start_city
  current_coordinates = cities_copy[start_city]
  path = [start_city]
  cities_copy.delete(start_city)

  # while the copy has elements
  while !cities_copy.empty?

    # set the min to a distance greater than the map's greatest distance
    min = 1000000

    # initialize closest city, so it is in scope when we push it to the path
    closest_city = ""

    # cycle through the unvisited cities
    cities_copy.each do |key, value|

      # get their distance from current city
      distance = (current_coordinates[0] - value[0]) ** 2 + (current_coordinates[1] - value[1]) ** 2

      # if the distance is less than current min, then reset min to distance and closest city
      # to the key, which is the string of the citie's name
      if distance < min
        min = distance
        closest_city = key
      end
    end

    # after the closest city has been found, load its name to the path,
    # set the current city to the closest city and copy the array of coordinates 
    # for closest city so that they are the current coordinates and delete the 
    # city from the copy; only unvisited cities will be left
    path << closest_city
    current_city = closest_city
    current_coordinates = cities_copy[current_city]
    cities_copy.delete(closest_city)
  end
  path
end

western_cities = {}
western_cities["Seattle"] = [0,100]
western_cities["Portland"] = [0,80]
western_cities["San Francisco"] = [0,40]
western_cities["Los Angeles"] = [0,10]
western_cities["Phoenix"] = [20,5]
western_cities["Las Vegas"] = [17,17]
western_cities["San Diego"] = [0,0]
western_cities["Santa Fe"] = [50, 10]
western_cities["Denver"] = [50, 50]
western_cities["Boise"] = [20, 80]
western_cities["Helena"] = [40, 100]
western_cities["Salt Lake City"] = [35, 55]

path = find_path(western_cities, "San Diego")
puts path