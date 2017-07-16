local wx, wy = love.window.getMode()
local color = {255,255,255}
local scale = 10
local dots = {
    {
    dbo = true,
    act = true,
    pos = { x = wx/2, y = wy/2 },
    dir = { x = 0 , y = 1 }
  },
  {
  dbo = true,
  act = true,
  pos = { x = wx/2, y = wy/2 },
  dir = { x = 1 , y = 0 }
},
{
dbo = true,
act = true,
pos = { x = wx/2, y = wy/2 },
dir = { x = -1 , y = 0 }
},
{
dbo = true,
act = true,
pos = { x = wx/2, y = wy/2 },
dir = { x = 0 , y = -1 }
},

}
local str = "dots \n \n"
function love.keypressed(key, scancode, isrepeat)
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
           if dots[l].act then
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
