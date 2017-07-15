local str = [[multi
line
string
is very darn long ok]]
print(string, "\n")

print(string.format("multi line string is %d characters long", string.len(str)), "\n")

newStr, changesMade = string.gsub(str, "s", "z")

print("now with s replaced by z:\n", newStr)
print("The above operation changed "..tostring(changesMade).." characters")

print("now for my next trick I shall write and 256 times")

i = 1
local newstr = "and"
while i <= 8 do
  newstr = newstr .. newstr
  i = i + 1
end
print(newstr)
print(#newstr/3)

print("that was fun. Now the fibonnaci sequence to its n:th value")
u = 1
p = 0
for i = 1, 10 do
  o = u
  u = u + p
  print(u)
  p = o
end
print("\n",#[[u = 1
p = 0
for i = 1, 10 do
  o = u
  u = u + p
  print(u)
  p = o
end]])
