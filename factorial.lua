local num = 12
local sum = 1

for i = num/math.abs(num), num, num/math.abs(num) do
  sum = sum * i
  print(i, sum)
end
