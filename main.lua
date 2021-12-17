local width = 300
local height = 300

local player = {
	x = 150,
	y = 150,
	speed = 1,
	hx = 0,
	hy = 0,
	attacking = false,
	dir = ""
}

local camera = {x = 0, y = 0}

local grass = 0
local wall = 1

local blocks = {
	[wall] = true,
}

local sprites = {
	[grass] = love.graphics.newImage("grass.png"),
	[wall] = love.graphics.newImage("wall.png"),
}

local anim8 = require("anim8")

local playersheet = love.graphics.newImage("sheet.png")
local walkdown = 2
local walkup = 3
local walkleft = 4
local walkright = 5
local rightattack = 6
local upattack = 7
local downattack = 8
local leftattack = 9

local dirattack = {
	["up"] = upattack,
	["down"] = downattack,
	["left"] = leftattack,
	["right"] = rightattack
}

local animations = {}
local currentanimation

local cs = 30

local map = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

function upcollide()
	local ax = math.floor(player.x / cs) + 1
	local ay = math.floor((player.y - player.speed) / cs) + 1

	local bx = math.floor((player.x + cs - 1) / cs) + 1
	local by = math.floor((player.y - player.speed) / cs) + 1

	return blocks[map[ay][ax]] or blocks[map[by][bx]]
end

function downcollide()
	local cx = math.floor(player.x / cs) + 1
	local cy = math.floor((player.y + cs - 1 + player.speed) / cs) + 1

	local dx = math.floor((player.x + cs - 1) / cs) + 1
	local dy = math.floor((player.y + cs - 1 + player.speed) / cs) + 1

	return blocks[map[cy][cx]] or blocks[map[dy][dx]]
end

function leftcollide()
	local ax = math.floor((player.x - player.speed) / cs) + 1
	local ay = math.floor(player.y / cs) + 1

	local cx = math.floor((player.x - player.speed) / cs) + 1
	local cy = math.floor((player.y + cs - 1) / cs) + 1

	return blocks[map[ay][ax]] or blocks[map[cy][cx]]
end

function rightcollide()
	local bx = math.floor((player.x + cs - 1 + player.speed) / cs) + 1
	local by = math.floor(player.y / cs) + 1

	local dx = math.floor((player.x + cs - 1 + player.speed) / cs) + 1
	local dy = math.floor((player.y + cs - 1) / cs) + 1

	return blocks[map[by][bx]] or blocks[map[dy][dx]]
end

function confighurtbox(_x, _y)
	player.hx = _x
	player.hy = _y
end

function love.load()
	local g = anim8.newGrid(64, 64, playersheet:getWidth(), playersheet:getHeight())
	local animationspeed = 0.1
	animations[walkup] = anim8.newAnimation(g('7-12', 1), animationspeed)
	animations[walkdown] = anim8.newAnimation(g('19-24', 1), animationspeed)
	animations[walkleft] = anim8.newAnimation(g('13-18', 1), animationspeed)
	animations[walkright] = anim8.newAnimation(g('1-6', 1), animationspeed)
	animations[upattack] = anim8.newAnimation(g('29-32', 1), animationspeed, function()
		player.attacking = false
		currentanimation = walkup
	end)
	animations[downattack] = anim8.newAnimation(g('37-40', 1), animationspeed, function()
		player.attacking = false
		currentanimation = walkdown
	end)
	animations[leftattack] = anim8.newAnimation(g('33-36', 1), animationspeed, function()
		player.attacking = false
		currentanimation = walkleft
	end)
	animations[rightattack] = anim8.newAnimation(g('25-28', 1), animationspeed, function()
		player.attacking = false
		currentanimation = walkright
	end)

	player.dir = "down"
	currentanimation = walkdown
	confighurtbox(player.x+cs/2, player.y + cs+4)
end

function love.keypressed(key)
	if key == "z" then
		player.attacking = true
		currentanimation = dirattack[player.dir]
	end
end

function love.update(dt)
	local up = love.keyboard.isDown("up")
	local down = love.keyboard.isDown("down")
	local left = love.keyboard.isDown("left")
	local right = love.keyboard.isDown("right")

	if not player.attacking then
		if up then
			currentanimation = walkup
			if not upcollide() then
				player.y = player.y - player.speed
			end
			confighurtbox(player.x+cs/2, player.y+5 )
			player.dir = "up"
		end

		if down then
			currentanimation = walkdown
			if not downcollide() then
				player.y = player.y + player.speed
			end
			confighurtbox(player.x+cs/2, player.y + cs+4)
			player.dir = "down"
		end

		if left then
			currentanimation = walkleft
			if not leftcollide() then
				player.x = player.x - player.speed
			end
			confighurtbox(player.x, player.y+cs/2)
			player.dir = "left"
		end

		if right then
			currentanimation = walkright
			if not rightcollide() then
				player.x = player.x + player.speed
			end
			confighurtbox(player.x + cs, player.y+cs/2)
			player.dir = "right"
		end
	end

	if up or down or left or right or player.attacking then
		animations[currentanimation]:update(dt)
	else
		animations[currentanimation]:gotoFrame(1)
	end

	camera.x = player.x - (width/2)
	camera.y = player.y - (height/2)
end

function love.draw()
	--local inix = math.max(1, math.floor(camera.x/cs)+1)
	local inix = math.floor(camera.x/cs)+1
	
	--local endx = math.min(20, math.floor(width/cs)+(camera.x/cs)+1)
	local endx = math.floor(width/cs)+(camera.x/cs)+1
	
	--local iniy = math.max(1, math.floor(camera.y/cs)+1)
	local iniy = math.floor(camera.y/cs)+1

	--local endy = math.min(20, math.floor(height/cs)+(camera.y/cs)+1)
	local endy = math.floor(height/cs)+(camera.y/cs)+1

	--love.graphics.setColor(0.7, 0.7, 0.7)
	for i = iniy, endy do
		for j = inix, endx do
			love.graphics.draw(sprites[map[i][j]], (j-1)*cs - camera.x, (i-1)*cs - camera.y)
		end
	end

	--love.graphics.rectangle("fill", player.x - camera.x, player.y - camera.y, cs, cs)
	animations[currentanimation]:draw(playersheet, player.x-camera.x-16, player.y-camera.y-16)

	--love.graphics.setColor(1, 0, 0)
	--love.graphics.rectangle("line", player.hx - camera.x, player.hy - camera.y, cs, cs)
	love.graphics.circle("line", player.hx - camera.x, player.hy - camera.y, 8)
	--love.graphics.reset()
end