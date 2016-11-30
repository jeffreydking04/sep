def linear_search_worst_case_iterations(n)
  puts "Collection size       Worst case iterations for Linear Search"
  (1..n).each do |x|
    puts "#{x}                     #{x}"
  end
end

linear_search_worst_case_iterations(9)