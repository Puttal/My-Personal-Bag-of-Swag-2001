love.window.setFullscreen(true)
math.randomseed(os.time())
love.keyboard.setKeyRepeat(true)
local caninactdbo = true
local symmetry = true
local symmetryy = true
local wx, wy = love.window.getMode()
local color = {255,255,255}
local scale = 10
local dots = {}
for i = 1, math.ceil(math.random(1, 4)) do
  dots[i] = {
    dbo = true,
    act = true,
    pos = { x = wx/2 + scale * math.ceil(math.random(-3,3)), y = wy/2 + scale * math.ceil(math.random(-3,3)) },
    dir = { x = math.ceil(math.random(-1,1)), y = math.ceil(math.random(-1,1)) },
  }
  print(dots[i].pos.x,dots[i].pos.y,dots[i].dir.x,dots[i].dir.y)
  print("success-ish")
end
print(wx,wy,"window")
if symmetry  then for i = 1, #dots do
  local k = #dots + 1
  dots[k] = {
    dbo = true,
    act = true,
    pos = { x = wx - dots[i].pos.x , y = wy - dots[i].pos.y },
    dir = { x = dots[i].dir.x * -1 , y =  dots[i].dir.y * -1 }
  }
  print(dots[k].pos.x,dots[k].pos.y,dots[k].dir.x,dots[k].dir.y)
  print("success")
end end
if symmetryy  then for i = 1, #dots do
  local k = #dots + 1
  dots[k] = {
    dbo = true,
    act = true,
    pos = { x =dots[i].pos.x , y = wy - dots[i].pos.y },
    dir = { x = dots[i].dir.x , y =  dots[i].dir.y * -1 }
  }
  print(dots[k].pos.x,dots[k].pos.y,dots[k].dir.x,dots[k].dir.y)
  print("success")
end end
function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
      love.window.close()
    end
    if key == "h" then
     for k = 1, #dots do
       if dots[k].act then
         local i = #dots + 1
         local j = #dots + 2
         dots[i] = {
          dbo = true,
          act = true,
          pos = {
            x = dots[k].pos.x + scale * dots[k].dir.x,
            y = dots[k].pos.y + scale * dots[k].dir.y
          },
          dir = {
            x = 0,
            y = 0
          }
         }
         dots[j] = {
          dbo = true,
          act = true,
          pos = {
            x = dots[k].pos.x + scale * dots[k].dir.x,
            y = dots[k].pos.y + scale * dots[k].dir.y
          },
          dir = {
            x = 0,
            y = 0
          }
         }
         if math.abs(dots[k].dir.x + dots[k].dir.y) == 1 then
           if dots[k].dir.x == 0 then
             dots[i].dir.x = 1
             dots[i].dir.y = dots[k].dir.y
             dots[j].dir.x = -1
             dots[j].dir.y = dots[k].dir.y
           else
             dots[i].dir.x = dots[k].dir.x
             dots[i].dir.y = 1
             dots[j].dir.x = dots[k].dir.x
             dots[j].dir.y = -1
           end
         else
           dots[i].dir.x = dots[k].dir.x
           dots[i].dir.y = 0
           dots[j].dir.x = 0
           dots[j].dir.y = dots[k].dir.y
         end
         dots[k].act = false
         k = k + 1
       end
     end
     for k = 1, #dots do
       if dots[k].dbo and dots[k].act then
       for l = 1, #dots do
         if dots[k].pos.x == dots[l].pos.x and dots[k].pos.y == dots[l].pos.y and math.abs(k-l) > 1 then
           dots[k].act = false
           dots[k].dbo = false
           if dots[l].act or caninactdbo then
             dots[l].act = false
             dots[l].dbo = false
           end
           --print(string.format("killed %d and %d", l, k))
         end
         l = l + 1
       end
      end
     end
   end
end

function love.draw()
  for k, v in pairs(dots) do
    if v.dbo then
      love.graphics.setColor(color)
      love.graphics.line(v.pos.x, v.pos.y, v.pos.x + scale * v.dir.x, v.pos.y + scale * v.dir.y)
    end
    if v.act == false then
      love.graphics.setColor(255, 0, 0)
      --love.graphics.circle("fill", v.pos.x, v.pos.y, 1 )
    end
  end
end
