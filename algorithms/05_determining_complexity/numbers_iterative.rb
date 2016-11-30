def iterative(n)
  return 0 if n == 0
  num1 = 0
  num2 = 1
  i = 0
  while i < n-1
    tmp = num1 + num2
    num1 = num2
    num2 = tmp
    i+=1
  end
  num2
end

11.times do |x|
  puts iterative(x+1)
end

puts iterative(200000)
