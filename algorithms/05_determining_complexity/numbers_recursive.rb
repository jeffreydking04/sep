def numbers(n, count)
  count[0] += 1
  if (n == 0)
    return 0
  elsif (n == 1)
    return 1
  else
    return numbers(n-1, count) + numbers(n-2, count)
  end
end

#count = [0]
#numbers(40,count)
#puts count[0]

def numbers_iterations(n)
  return 1 if n == 0
  return 1 if n == 1
  sum1 = 1
  sum2 = 1
  (2..n).each do |x|
    temp = sum2
    sum2 = sum1 + sum2 + 1
    sum1 = temp
  end
  sum2
end

def factorial(n)
  return 1 if n == 0
  product = 1
  (1..n).each do |x|
    product *= x
  end
  product
end


def numbers(n)
 if (n == 0)
   return 0
 elsif (n == 1)
   return 1
 else
   return numbers(n-1) + numbers(n-2)
 end
end

(500..505).each do |x|
  num = numbers_iterations(x)
  num1 = 1.62 ** x
  num2 = num1 - num
  puts "#{x}: dif: #{num2}"
end