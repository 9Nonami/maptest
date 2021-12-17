--player

local player = {
	x = 16*scale,
	y = 16*scale,
	speed = 1,
	sprite = love.graphics.newImage("player.png"),
	dir = "down"
}

local target = {
	x = 0,
	y = 0,
	r = 15
}

function upcollide(map)
	local ax = math.floor(player.x / cs) + 1
	local ay = math.floor((player.y - player.speed) / cs) + 1

	local bx = math.floor((player.x + cs - 1) / cs) + 1
	local by = math.floor((player.y - player.speed) / cs) + 1

	return blocks[map[ay][ax]] or blocks[map[by][bx]]
end

function downcollide(map)
	local cx = math.floor(player.x / cs) + 1
	local cy = math.floor((player.y + cs - 1 + player.speed) / cs) + 1

	local dx = math.floor((player.x + cs - 1) / cs) + 1
	local dy = math.floor((player.y + cs - 1 + player.speed) / cs) + 1

	return blocks[map[cy][cx]] or blocks[map[dy][dx]]
end

function leftcollide(map)
	local ax = math.floor((player.x - player.speed) / cs) + 1
	local ay = math.floor(player.y / cs) + 1

	local cx = math.floor((player.x - player.speed) / cs) + 1
	local cy = math.floor((player.y + cs - 1) / cs) + 1

	return blocks[map[ay][ax]] or blocks[map[cy][cx]]
end

function rightcollide(map)
	local bx = math.floor((player.x + cs - 1 + player.speed) / cs) + 1
	local by = math.floor(player.y / cs) + 1

	local dx = math.floor((player.x + cs - 1 + player.speed) / cs) + 1
	local dy = math.floor((player.y + cs - 1) / cs) + 1

	return blocks[map[by][bx]] or blocks[map[dy][dx]]
end

return {
	update = function(map)
		local up = love.keyboard.isDown("up")
		local down = love.keyboard.isDown("down")
		local left = love.keyboard.isDown("left")
		local right = love.keyboard.isDown("right")

		local sx, sy = 0, 0

		if up and not upcollide(map) then
			sy = sy - player.speed
			player.dir = "up"
		end
		if down and not downcollide(map) then
			sy = sy + player.speed
			player.dir = "down"
		end
		if left and not leftcollide(map) then
			sx = sx - player.speed
			player.dir = "left"
		end
		if right and not rightcollide(map) then
			sx = sx + player.speed
			player.dir = "right"
		end
		player.x = player.x + sx
		player.y = player.y + sy
	end,

	draw = function()
		love.graphics.draw(player.sprite, player.x-camera.x, player.y-camera.y, nil, scale, scale)
		love.graphics.print(player.dir)
	end,

	getplayer = function()
		return player
	end
}