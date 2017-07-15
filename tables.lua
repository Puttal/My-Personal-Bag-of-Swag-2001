function tabstr(a)
  local tempstring = " \n contents of " .. tostring(a)
  for k, v in pairs(a) do
    tempstring = tempstring .. "\n key : \t" .. k .. "\t value :\t" .. v
  end
  return tempstring
end

tabul = {"noon", "noot", "spazz", "gineers", "koko"}

print(tabstr(tabul))

doubletab = {}

print(" \n doubletab")
for i = 1 , 8 do
  doubletab[i] = math.pow(2, i)
end

print(tabstr(doubletab))

tripletab = {}
print("\n tripletab")

for i = 1, 8 do
  table.insert(tripletab, i, math.pow(3, i))
end

print(tabstr(tripletab))


tabul = {"noon", "noot", "spazz", "gineers", "koko"}

for i = 6, 9 do
  tabul[i] = i
end

tabul.hello = "something"

table.insert(tabul, 9, "else")

print(tabstr(tabul))
