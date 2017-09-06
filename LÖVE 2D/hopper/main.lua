local wx, wy = love.window.getMode()
local mx, my = {0,0}
local aimvec = {1,1}
local playerpos = {0,0}
local function clamp(value, min, max)
return math.max(math.min(value,max),min)
end
local ent = {
  player = {
    type = "rectangle",
    drawmode = "fill",
    grav = true,
    move = true,
    pos = {wx/2-20, wy/2+40},
    health = 100,
    vel = {0,0},
    height = 80,
    width = 40,
    color = {255,255,255},
    speed = 750,
    jumpcount = 2,
    curjumps = 0,
    canjump = true,
    },
    blinker = {
      type = "circle",
      drawmode = "line",
      r = 5,
      pos = {0,0},
      active = true,
      color = {0,0,255},
      range = 250,
    },
}

function love.update(Dt)
  playerpos = {ent.player.pos[1] + ent.player.width/2, ent.player.pos[2] + ent.player.height/2}
  mx, my = love.mouse.getPosition()
  aimvec[1] = (mx - playerpos[1]) / math.sqrt(math.pow(playerpos[1] - mx, 2) + math.pow(playerpos[2] - my, 2))
  aimvec[2] = (my - playerpos[2]) / math.sqrt(math.pow(playerpos[1] - mx, 2) + math.pow(playerpos[2] - my, 2))

  if math.sqrt(math.pow(playerpos[1] - mx, 2) + math.pow(playerpos[2] - my, 2)) > ent.blinker.range then
    ent.blinker.pos[1] = playerpos[1] + aimvec[1] * ent.blinker.range
    ent.blinker.pos[2] = playerpos[2] + aimvec[2] * ent.blinker.range
  else
    ent.blinker.pos[1] = mx
    ent.blinker.pos[2] = my
  end

  if love.keyboard.isDown("a") and not love.keyboard.isDown("d") then
    ent.player.vel[1] = -ent.player.speed
  elseif love.keyboard.isDown("d") and not love.keyboard.isDown("a") then
    ent.player.vel[1] = ent.player.speed
  else
    ent.player.vel[1] = 0
  end

  if love.keyboard.isDown("w") and ent.player.curjumps ~= 0 and ent.player.canjump then
    ent.player.vel[2] = -800
    ent.player.canjump = false
    ent.player.curjumps = ent.player.curjumps - 1
  end
  if not love.keyboard.isDown("w") then
    ent.player.canjump = true
  end
  if ent.player.pos[1] >= wx - ent.player.width or ent.player.pos[1] <= 0 or ent.player.pos[2] >= wy - ent.player.height then
    ent.player.curjumps = ent.player.jumpcount
  end

  if love.keyboard.isDown("s") and ent.player.curjumps ~= 0 and ent.blinker.active then
    ent.player.pos[1] = ent.blinker.pos[1] - ent.player.width/2
    ent.player.pos[2] = ent.blinker.pos[2] - ent.player.height/2
    ent.player.vel[2] = 0
    ent.blinker.active = false
    ent.player.curjumps = ent.player.curjumps - 1
  end
  if not love.keyboard.isDown("s") then
    ent.blinker.active = true
  end

  for k, v in pairs(ent) do
    if v.grav == true then
      v.vel[2] = v.vel[2] + 1600 * Dt
    end
    if v.move then
      v.pos[1], v.pos[2] = v.pos[1] + v.vel[1] * Dt , v.pos[2] + v.vel[2] * Dt
    end
    if v.type == "rectangle" then
      v.pos[1], v.pos[2] = clamp(v.pos[1],0 ,wx - v.width ), clamp(v.pos[2],0 ,wy - v.height )
    elseif v.type == "circle" then
      v.pos[1], v.pos[2] = clamp(v.pos[1],v.r ,wx ), clamp(v.pos[2],v.r ,wy - v.r )
    else
      v.pos[1], v.pos[2] = clamp(v.pos[1],0 ,wx ), clamp(v.pos[2],0 ,wy )
    end
  end
end

function love.draw()
  for k, v in pairs(ent) do
    if v.type == "rectangle" then
      love.graphics.setColor(v.color)
      love.graphics.rectangle(v.drawmode, v.pos[1], v.pos[2], v.width, v.height)
    elseif v.type == "circle" then
      love.graphics.setColor(v.color)
      love.graphics.circle(v.drawmode, v.pos[1], v.pos[2], v.r)
    end
  end
  love.graphics.setColor(255,255,255)
  love.graphics.line(playerpos[1], playerpos[2], ent.blinker.pos[1], ent.blinker.pos[2])
end
