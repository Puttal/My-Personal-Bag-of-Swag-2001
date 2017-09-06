local wx, wy = love.window.getMode()
local clicks = 0
local cpc = 1
local buttscale = 1
local butt = {
  color = {255, 0, 0},
  x = wx / 2,
  y = wy / 2,
  r = math.max(wx, wy) / 4,
}
love.graphics.setNewFont(18)
local hitnums = {}

function love.mousepressed(x, y, button)
  if button == 1 then
    if math.pow(x - butt.x, 2) + math.pow(y - butt.y, 2) < math.pow(butt.r, 2) then
      buttscale = 4 / 5
      clicks = clicks + cpc
      hitnums[#hitnums + 1] = {
        x = math.random(wx / 2 - butt.r, wx / 2 + butt.r),
        y = math.random(wy / 2 - butt.r, wy / 2 + butt.r),
        timeleft = 3,
        str = string.format("+ %d", cpc),
      }
    end
  end
end

function love.mousereleased(x, y, button)
  if button == 1 then
    buttscale = 1
  end
end

function love.draw()
  love.graphics.setColor(butt.color)
  love.graphics.circle("fill", butt.x, butt.y, butt.r * buttscale)
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf(string.format("%d clicks", clicks), wx / 2, wy / 2, 200, "center", 0, buttscale, buttscale, 100, 10 * buttscale, 0)
  love.graphics.circle("line", wx / 2, wy / 2, 100 * buttscale)
  love.graphics.circle("line", butt.x, butt.y, butt.r * buttscale)
  for k, v in pairs(hitnums) do
    love.graphics.setColor(255, 255, 255, v.timeleft * 255 / 3)
    love.graphics.print(v.str, v.x, v.y)
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(#hitnums)
end

function love.update(dt)
  for k, v in pairs(hitnums) do
    v.y = v.y - dt * 60
    v.timeleft = v.timeleft - dt
    if v.timeleft < 0 then
      hitnums[k] = nil
    end
  end
end
