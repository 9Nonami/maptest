--main

--love.graphics.setDefaultFilter("nearest", "nearest")

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local dt = 0

local grass = 0
local wall = 1

local sprites = {
	[grass] = love.graphics.newImage("grass.png"),
	[wall] = love.graphics.newImage("wall.png")
}

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
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1},
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

local blocks = {
	[wall] = true
}

local cs = 32

------------------------------------------------------------------------------

local player = {
	x = 32*5,
	y = 32*5,
	sprite = love.graphics.newImage("player.png"),
	speed = 60
}

local function upcollide()
	local ax = math.floor(player.x / cs) + 1
	local ay = math.floor((player.y - player.speed*dt) / cs) + 1

	local bx = math.floor((player.x + cs - 1) / cs) + 1
	local by = math.floor((player.y - player.speed*dt) / cs) + 1
	
	if blocks[map[ay][ax]] or blocks[map[by][bx]] then
		return ay * cs
	end

	return false
end

local function downcollide()
	local cx = math.floor(player.x / cs) + 1
	local cy = math.floor((player.y + cs + player.speed*dt) / cs) + 1

	local dx = math.floor((player.x + cs - 1) / cs) + 1
	local dy = math.floor((player.y + cs + player.speed*dt) / cs) + 1

	if blocks[map[cy][cx]] or blocks[map[dy][dx]] then
		return (cy * cs) - (2 * cs)
	end

	return false
end

local function leftcollide()
	local ax = math.floor((player.x - player.speed*dt) / cs) + 1
	local ay = math.floor(player.y / cs) + 1

	local cx = math.floor((player.x - player.speed*dt) / cs) + 1
	local cy = math.floor((player.y + cs - 1) / cs) + 1

	if blocks[map[ay][ax]] or blocks[map[cy][cx]] then
		return ax * cs
	end
	
	return false
end

local function rightcollide()
	local bx = math.floor((player.x + cs + player.speed*dt) / cs) + 1
	local by = math.floor(player.y / cs) + 1

	local dx = math.floor((player.x + cs + player.speed*dt) / cs) + 1
	local dy = math.floor((player.y + cs - 1) / cs) + 1

	if blocks[map[by][bx]] or blocks[map[dy][dx]] then
		return (bx * cs) - (2 * cs)
	end

	return false
end

local camera = {x = 0, y = 0}

function love.update(_dt)
	dt = _dt

	local up = love.keyboard.isDown("up")
	local down = love.keyboard.isDown("down")
	local left = love.keyboard.isDown("left")
	local right = love.keyboard.isDown("right")

	if up then
		local y = upcollide()
		if y then
			player.y = y
		else
			player.y = player.y - player.speed * dt
		end
	elseif down then
		local y = downcollide()
		if y then
			player.y = y
		else
			player.y = player.y + player.speed * dt
		end
	end
	
	if left then
		local x = leftcollide()
		if x then
			player.x = x
		else
			player.x = player.x - player.speed * dt
		end
	elseif right then
		local x = rightcollide()
		if x then
			player.x = x
		else
			player.x = player.x + player.speed * dt
		end
	end
	
	camera.x = player.x - (width/2)
	camera.y = player.y - (height/2)
end

function love.draw()

	local inix = math.floor(camera.x/cs)+2
	local endx = math.floor((width/cs)+(camera.x/cs))+1
	local iniy = math.floor(camera.y/cs)+2
	local endy = math.floor((height/cs)+(camera.y/cs))+1

	for i = iniy-1, endy+1 do
		for j = inix-1, endx+1 do
			love.graphics.draw(sprites[map[i][j]], (j-1)*cs - camera.x-16, (i-1)*cs - camera.y-16)
		end
	end
	
	love.graphics.draw(player.sprite, player.x - camera.x - 16, player.y - camera.y - 16)

	--[[
	for i = 1, height/cs do
		for j = 1, width/cs do
			love.graphics.rectangle("line", (j-1)*cs, (i-1)*cs, cs, cs)
		end
	end--]]
end
