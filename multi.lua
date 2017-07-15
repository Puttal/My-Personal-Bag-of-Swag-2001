function tabstr(a)
  local tempstring = " \n contents of " .. tostring(a)
  for k, v in pairs(a) do
    tempstring = tempstring .. "\n key : \t" .. k .. "\t value :\t" .. v
  end
  return tempstring
end

tablea = {}

for i = 1, 10 do
  tablea[i] = i
end

print(tabstr(tablea))

function multicon(...)
  local tempstring = ""
  for k, v in pairs{...} do
    tempstring = tempstring .. v
  end
  return tempstring
end

print(multicon("hello ", "I ", "am ", "the ", "best"))
