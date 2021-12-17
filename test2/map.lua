--map

local grass = 0
local wall = 1

table.insert(blocks, wall)

local sprites = {
	[grass] = love.graphics.newImage("grass.png"),
	[wall] = love.graphics.newImage("wall.png")
}

local map = {
	{1, 1, 1, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 0, 0, 1},
	{1, 1, 1, 1},
}

return {
	draw = function()
		for i = 1, #map do --1~3
			for j = 1, #map[i] do --1~4
				love.graphics.draw(sprites[map[i][j]], (j-1)*cs - camera.x, (i-1)*cs - camera.y, nil, scale, scale)
			end
		end
	end,

	getmap = function()
		return map
	end
}