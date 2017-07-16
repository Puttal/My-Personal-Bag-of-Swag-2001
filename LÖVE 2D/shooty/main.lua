require("functions")
local wx, wy = love.window.getMode() --Get the screen size
love.window.setMode(wx, wy, {vsync=false})
local ship = {x = wx / 2, y = wy - 40, col = {255, 0, 0}, speed = 500} --Put the rocket thingy in the bottom middle of the screen

local bullets = {}
local cooldown = 0
local fireRate = 0.1
local bulletspeed = 500

local enemies = {}
enemyCooldown = 3
lastEnemy = 0
enemySpeed = 50
cooldownUpspeed = 0.9

function love.draw()
	love.graphics.setColor(ship.col)
	love.graphics.polygon("fill", ship.x, ship.y, ship.x - 20, ship.y + 30, ship.x + 20, ship.y + 30)

	love.graphics.setColor(0, 255, 0)
	for k, v in pairs(bullets) do
		love.graphics.line(v.x, v.y, v.x, v.y + 10)
	end

	for k, v in pairs(enemies) do
		love.graphics.setColor(v.col)
		love.graphics.circle("fill", v.x, v.y, v.rad)
	end
end

function love.update(Dt)

	lastEnemy = lastEnemy - Dt
	if lastEnemy <= 0 then
		enemies[firstEmptyKey(enemies)] = {
			y = -10,
			x = math.random(0, wx),
			rad = 40,
			col = {math.random(0,255),math.random(0,255),math.random(0,255)},
		}
		lastEnemy = enemyCooldown
	end

	cooldown = cooldown - Dt
	if love.keyboard.isDown("a") then
		ship.x = clamp(ship.x - ship.speed * Dt, 20, wx - 20)
	elseif love.keyboard.isDown("d") then
		ship.x = clamp(ship.x + ship.speed * Dt, 20, wx - 20)
	end

	for k, v in pairs(bullets) do
		v.y = v.y - bulletspeed * Dt
		if v.y < 0 then
			bullets[k] = nil
		end
		for i, j in pairs(enemies) do
			if distance(v.x, v.y, j.x, j.y) < j.rad then
				bullets[k] = nil
				enemies[i] = nil
				enemyCooldown = enemyCooldown * cooldownUpspeed
			end
		end
	end

	for k, v in pairs(enemies) do
		v.y = v.y + enemySpeed * Dt
		if v.y > wy then 
			enemies[k] = nil
		end
	end
end

function love.keypressed(key)
	if key == "space" then
		if cooldown <= 0 then
			bullets[firstEmptyKey(bullets)] = {x = ship.x, y = ship.y}
			cooldown = fireRate
		end
	end
end
