
local dodges = {}
local wx, wy = love.window.getMode()
local player = {
  drawmode = "fill",
  x = wx / 2,
  y = wy - 35,
  r = 25,
  color = {0, 255, 255},
  speed = 250,
}
local tsl = 0
local score = 0
local dodges = {}
local moveleft = false
local moveright = false
local gameover = love.audio.newSource("sfx/scratch.wav", "static")
local function clamp(min, val, max)
  return math.max(min, math.min(val, max))
end
love.graphics.setNewFont(64)

love.keyboard.setKeyRepeat( true )

function love.keypressed(key)
  if key == "d" then
    moveright = true
  end
  if key == "a" then
    moveleft = true
  end
  if key == "escape" then
    love.event.quit()
  end
end

function love.keyreleased(key)
  if key == "d" then
    moveright = false
  end
  if key == "a" then
    moveleft = false
  end
end

function love.update(Dt)
  score = score + Dt
  Dt = Dt * (60 + score) / 60
  tsl = tsl + Dt
  if moveright then
    player.x = player.x + player.speed * Dt
  end
  if moveleft then
    player.x = player.x - player.speed * Dt
  end
  player.x = clamp(30, player.x, wx - 30)
  for k, v in pairs(dodges) do
    if v ~= nil then
      if math.sqrt(math.pow(v.x - player.x, 2) + math.pow(v.y - player.y, 2)) < v.r + player.r then
        gameover:play()
        score = 0
        math.randomseed(1)
      end
      v.y = v.y + v.speed * Dt
      if v.y > wy + v.r then
        dodges[k] = nil
      end
    end
  end
  if tsl > 0.25 then
    local r = math.random(10, 50)
    dodges[#dodges + 1] = {
      drawmode = "fill",
      r = r,
      x = math.random(r, wx - r),
      y = - r,
      color = {math.random(150, 255), math.random(0, 150), 0},
      speed = math.random(250, 750),
    }
    tsl = 0
  end
  local iter = 0
  local iter2 = 0
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf(string.format("%.2f", score), wx / 2 - 300, wy / 2 - 50, 600, "center")
  love.graphics.setColor(player.color)
  love.graphics.circle(player.drawmode, player.x, player.y, player.r)
  for k, v in pairs(dodges) do
    if v ~= nil then
      love.graphics.setColor(v.color)
      love.graphics.circle(v.drawmode, v.x, v.y, v.r)
    end
  end
end
