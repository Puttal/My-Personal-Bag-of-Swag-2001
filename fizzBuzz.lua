local tempstr = ""
for i  = 1, 100 do
  local num = true
  local tempstr = ""
  if i % 3 == 0 then
    num = false
    tempstr = "Fizz"
  end
  if i % 5 == 0 then
    num = false
    tempstr = tempstr .. "Buzz"
  end
  if num then
    print(num)
  else
    print(tempstr)
  end
end
