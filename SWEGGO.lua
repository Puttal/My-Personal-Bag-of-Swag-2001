

T1 = true
T2 = false
T3 = not true


Variable  = "Hello swegger"
Variable2 = 2
Variable3 = 4
Variable4 = tostring(Variable2)..Variable

print(Variable4)

for i = 1, 10 do
  print(i)
  if i%2 == 0 then
      print(tostring(i).." is even")
    else
      print(tostring(i).. "is odd")
    end
end


Count = 10
var1 = 1
var2 = 0
var3 = 0
for i = 1, Count do

  print(var1)

  var3 = var1
  var1 = var1 + var2
  var2 = var3

  end

  Num = 2
  while Num < 300 do
    print(Num)
    Num = Num * 2
  end

  Num2 = 2
  repeat
    print(Num2)
    Num2 = Num2 * 2
  until Num2 > 300



were = {}
were.hi = "1"
were.oi = "one"
were["rursus"] = "1"
were.sursus = 1

for k, v in pairs(were) do
  print(k,v)
end

print("next")

function tablelength(Table)
  local Num = 0
  for K, V in pairs(Table) do
    Num = Num + 1
  end
  return Num
end

print(tablelength(were))

print("NEXT THING")
