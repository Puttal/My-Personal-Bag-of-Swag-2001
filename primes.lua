function isPrime(number)
  if number == 2 then
    return true
  end
  if number == 1 or number % 2 == 0 then
    return false
  end
  for i = 3, math.ceil(math.sqrt(number)), 2 do
    if number % i == 0 then
      return false
    end
  end
  return true
end

for j = 0, 100 do
  print(j, isPrime(j))
end
