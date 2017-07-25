local timeleft = 3
local json = require("dkjson")
local fps = 0
local prev = 0
local pulsefactor = 15 --sets how big the square's pulse is
local highscore = {0}
if love.filesystem.exists( "score.lua" ) then
  local str = love.filesystem.read( "score.lua" )
  highscore = json.decode(str)
  print(highscore[1])
else
  print(love.filesystem.newFile( "score.lua" ), "made new score file")
end
local pulsestate = 0 --how far the pulse is (kind of)
local timemax = timeleft
local wx, wy = love.window.getMode() --wx and wy are the window x and y
local gamestarted = false
local bgmusic = love.audio.newSource( 'thingy.wav', 'stream' )
local gameover = love.audio.newSource("sfx/scratch.wav","static")
local click = love.audio.newSource("sfx/click.wav","static")
local timeplayed = 0
local sqoci = false --Chooses if the bad shape is square or circle
local badshapes = {}
local sq = { --The square
    x = wx/2 - 50,
    y = wy/2 - 50,
    w = 100, --Width
    h = 100, --Height
    color = {255,255,255}, --Color table, red, green and blue. Can also have alpha value
}
love.graphics.setNewFont(36)

function failcheck(x , y)
  for k, v in pairs(badshapes) do
    if v.type == "circle" then
      if math.pow((x - v.x), 2) + math.pow((y - v.y), 2) < math.pow(v.r, 2) then
        return true
      end
    elseif  v.type == "square" then
      if  x > v.x and
          x < v.x + sq.w and
          y > v.y and
          y < v.y + sq.h then
        return true
      end
    end
  end
end

function love.draw()
  love.graphics.setColor(255,0,0)
    love.graphics.print(string.format("%.2f", timeplayed), wx/2-50, wy/2-25, 0)
    love.graphics.setColor(sq.color) --Sets the current color
    love.graphics.rectangle("fill", sq.x - pulsestate/2, sq.y - pulsestate/2, sq.w + pulsestate, sq.h + pulsestate) --Draws the square. Fill means
    --that the whole square will be filled. "line" would draw an outline. Pulsestate added to make the pulse
    for k, v in pairs(badshapes) do
      if v.type == "circle" then
        love.graphics.setColor(v.color)
        love.graphics.circle("fill", v.x, v.y, v.r + pulsestate/2)
      end
      if v.type == "square" then
        love.graphics.setColor(v.color)
        love.graphics.rectangle("fill", v.x - pulsestate/2, v.y - pulsestate/2, v.w + pulsestate, v.h + pulsestate)
        print("drew a square")
      end
    end
    love.graphics.setBackgroundColor(150-timeleft*150/timemax,0,0)
    if gamestarted == false then
      love.graphics.setColor(255,0,0)
      love.graphics.print("Rage"..string.char(194, 178),  wx/2-50, wy/2 - 100)
      love.graphics.print(string.format("Highscore\t: %.2f \nPrevious\t   : %.2f", highscore[1], prev), wx/2-75, wy/2 + 60, 0, 0.5)
    end
    love.graphics.setColor(255,255,255)
end

function love.mousepressed(x, y, button)
    if button == 1 then --Button 1 is left mouse.
        if  x > sq.x and
            x < sq.x + sq.w and
            y > sq.y and
            y < sq.y + sq.h then
             sq.x = math.random(pulsefactor, wx - sq.w - pulsefactor) --Randomises the x and y of the box, but makes sure
             sq.y = math.random(pulsefactor, wy - sq.h - pulsefactor) --that the square will always be on the window
             --sq.color = {math.random(0, 255),math.random(0, 255),math.random(0, 255)} --Sets a
             --random color for the next box
             timeleft    = timeleft + 1
             gamestarted = true
             bgmusic:play()
             click:stop()
             click:play()
             for i = 1, math.floor(timeplayed/15) do
               if math.random(0, 2) > 1 then
                 local tempradius = 50
                 badshapes[i] =
                {
                  type = "circle",
                  x = math.random(pulsefactor + tempradius, wx - tempradius - pulsefactor),
                  y = math.random(pulsefactor + tempradius, wy - tempradius - pulsefactor),
                  r = tempradius,
                  color = {255,255,255}
                }
               else
                 local tempwidth = 100
                 local tempheight = 100
                 badshapes[i] =
                {
                  type = "square",
                  x = math.random(pulsefactor, wx - tempwidth - pulsefactor),
                  y = math.random(pulsefactor, wy - tempheight - pulsefactor),
                  w = tempwidth,
                  h = tempheight,
                  color = {255,0,0}
                }
               end
            end
        end
    end
end

function love.update(Dt)
  if gamestarted then
    timeleft = timeleft - Dt * (120+timeplayed)/120
    timeplayed = timeplayed + Dt
    pulsestate = pulsefactor * (math.abs(math.sin(4*math.pi*timeplayed))+math.abs(math.sin(2*math.pi*(timeplayed+0.125)))+math.abs(math.sin(math.pi*(timeplayed+0.375))))/3
    if timeleft > timemax then timeleft = timemax end
  end
  if timeleft <= 0 then
    prev = timeplayed
    if timeplayed > highscore[1] then
      highscore[1] = timeplayed
      local str = json.encode(highscore)
      love.filesystem.write( "score.lua", str)
    end
    love.audio.stop( )
    gameover:play()
    gamestarted = false
    timeleft = 3
    timeplayed = 0
    sq = { --The square
      x = wx/2 - 50,
      y = wy/2 - 50,
      w = 100, --Width
      h = 100, --Height
      color = {255,255,255}, --Color table, red, green and blue. Can also have alpha value
    }
    badshapes = {}
    love.graphics.setBackgroundColor(0,0,0)
  end
end
