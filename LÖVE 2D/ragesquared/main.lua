local sq = { --The square
    x = 0,
    y = 0,
    w = 100, --Width
    h = 100, --Height
    color = {255,255,255}, --Color table, red, green and blue. Can also have alpha value
}

local wx, wy = love.window.getMode() --wx and wy are the window x and y

function love.draw()
    love.graphics.setColor(sq.color) --Sets the current color
    love.graphics.rectangle("fill", sq.x, sq.y, sq.w, sq.h) --Draws the square. Fill means
    --that the whole square will be filled. "line" would draw an outline
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
        end
    end
end
