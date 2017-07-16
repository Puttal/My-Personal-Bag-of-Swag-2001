local timeleft = 3
local json = require("dkjson")
local fps = 0
local pulsefactor = 15 --sets how big the sqaure's pulse is
local highscore = {0}
if love.filesystem.exists( "score.lua" ) then
  local highscore = json.decode(love.filesystem.read( "score.lua" ))
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
local sq = { --The square
    x = wx/2 - 50,
    y = wy/2 - 50,
    w = 100, --Width
    h = 100, --Height
    color = {255,255,255}, --Color table, red, green and blue. Can also have alpha value
}
local bsq = { --The bad square
active = false, --For easier drawing and checking for clicks
x = wx/2 - 50,
y = wy/2 - 50,
w = 100, --Width
h = 100, --Height
color = {255,0,0}, --Color table, red, green and blue. Can also have alpha value
}
local bci = { --The bad circle
active = false,
x = wx/2 - 50,
y = wy/2 - 50,
r = 50, --Radius
color = {255,255,255},
}
love.graphics.setNewFont(36)

function love.draw()
  love.graphics.setColor(255,0,0)
    love.graphics.print(string.format("%.2f", timeplayed), wx/2-50, wy/2-25, 0)
    love.graphics.setColor(sq.color) --Sets the current color
    love.graphics.rectangle("fill", sq.x - pulsestate/2, sq.y - pulsestate/2, sq.w + pulsestate, sq.h + pulsestate) --Draws the square. Fill means
    --that the whole square will be filled. "line" would draw an outline. Pulsestate added to make the pulse
    if bsq.active then
      love.graphics.setColor(bsq.color)
      love.graphics.rectangle("fill", bsq.x - pulsestate/2, bsq.y - pulsestate/2, bsq.w + pulsestate, bsq.h + pulsestate)
    end
    if bci.active then
      love.graphics.setColor(bci.color)
      love.graphics.circle("fill", bci.x, bci.y, bci.r + pulsestate/2)
    end
    love.graphics.setBackgroundColor(150-timeleft*150/timemax,0,0)
    if gamestarted == false then
      love.graphics.setColor(255,0,0)
      love.graphics.print(string.format("Highscore : %.2f", highscore[1]), wx/2-75, wy/2 + 60, 0, 0.5)
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
             if timeplayed > 15 then --bad shapes start appearing
               sqoci = 0 == math.ceil(math.random(0, 100)) % 2
               bsq.active = not sqoci
               bci.active = sqoci
               bsq.x = math.random(pulsefactor, wx - bsq.w - pulsefactor)
               bsq.y = math.random(pulsefactor, wy - bsq.h - pulsefactor)
               bci.x = math.random(pulsefactor + bci.r, wx - bci.r - pulsefactor)
               bci.y = math.random(pulsefactor + bci.r, wy - bci.r - pulsefactor)
             end
          else if bsq.active and
             x > bsq.x and
             x < bsq.x + bsq.w and
             y > bsq.y and
             y < bsq.y + bsq.h then
              timeleft = 0
          else if bci.active and
            bci.r > math.sqrt(math.pow(x - bci.x, 2) + math.pow(y - bci.y, 2)) then
              timeleft = 0
            end
          end
        end
    end
end

function love.update(Dt)
  if gamestarted then
    timeleft = timeleft - Dt * (30+timeplayed)/30
    timeplayed = timeplayed + Dt
    pulsestate = pulsefactor * (math.abs(math.sin(4*math.pi*timeplayed))+math.abs(math.sin(2*math.pi*(timeplayed+0.125)))+math.abs(math.sin(math.pi*(timeplayed+0.375))))/3
    if timeleft > timemax then timeleft = timemax end
  end
  if timeleft <= 0 then
    if timeplayed > highscore[1] then
      highscore[1] = timeplayed
      print(love.filesystem.write( "score.lua", json.encode(highscore)), highscore[1])
    end
    bsq.active = false
    bci.active = false
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
    love.graphics.setBackgroundColor(0,0,0)
  end
end
