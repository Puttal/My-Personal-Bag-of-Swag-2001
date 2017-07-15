doubletab = {}

print(" \n doubletab")
for i = 1 , 8 do
  doubletab[i] = i
end

for k, v in pairs(doubletab) do
  print("key : ", k, " value : ", v)
end

doubletab[1] = "thing"
print(" \n next")
for k, v in pairs(doubletab) do
  print("key : ", k, " value : ", v)
end

print(" \n next")
table.insert(doubletab, 1, "otherthing")

for k, v in pairs(doubletab) do
  print("key : ", k, " value : ", v)
end

print(" \n next")
print(table.concat(doubletab, ", "))

table.remove(doubletab, 2)
print(" \n next")
for k, v in pairs(doubletab) do
  print("key : ", k, " value : ", v)
end

doubletab.greet = "hello"
print(" \n next")
for k, v in pairs(doubletab) do
  print("key : ", k, " value : ", v)
end
