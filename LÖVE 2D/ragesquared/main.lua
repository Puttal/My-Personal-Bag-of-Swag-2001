local timeleft = 3
local timemax = timeleft
local wx, wy = love.window.getMode() --wx and wy are the window x and y
local gamestarted = false
bgmusic = love.audio.newSource( 'thingy.wav', 'stream' )
gameover = love.audio.newSource("sfx/scratch.wav","static")
click = love.audio.newSource("sfx/click.wav","static")
local coloredtext = {
  color1 = {255,0,0},
  string1 = "window"
}
local timeplayed = 0
local sq = { --The square
    x = wx/2 - 50,
    y = wy/2 - 50,
    w = 100, --Width
    h = 100, --Height
    color = {255,255,255}, --Color table, red, green and blue. Can also have alpha value
}

function love.draw()
    love.graphics.print(string.format("%.2f", timeplayed), wx/2-50, wy/2-25, 0, 3, 3)
    love.graphics.setColor(sq.color) --Sets the current color
    love.graphics.rectangle("fill", sq.x, sq.y, sq.w, sq.h) --Draws the square. Fill means
    --that the whole square will be filled. "line" would draw an outline
    love.graphics.setColor(255,255,255)
    love.graphics.setBackgroundColor(150-timeleft*150/timemax,0,0)
    love.graphics.print(coloredtext)

end

function love.mousepressed(x, y, button)
    if button == 1 then --Button 1 is left mouse.
        if x > sq.x and
             x < sq.x + sq.w and
             y > sq.y and
             y < sq.y + sq.h then
             sq.x = math.random(0, wx - sq.w) --Randomises the x and y of the box, but makes sure
             sq.y = math.random(0, wy - sq.h) --that the square will always be on the window
             sq.color = {math.random(0, 255),math.random(0, 255),math.random(0, 255)} --Sets a
             --random color for the next box
             timeleft    = timeleft + 1
             gamestarted = true
             bgmusic:play()
             click:play()
        end
    end
end

function love.update(Dt)
  if gamestarted then
    timeleft = timeleft    - Dt * (30+timeplayed)/30
    timeplayed = timeplayed + Dt
    if timeleft > timemax then timeleft = timemax end
  end
  if timeleft < 0 then
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
