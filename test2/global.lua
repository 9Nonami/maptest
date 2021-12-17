--global

love.graphics.setDefaultFilter("nearest", "nearest")

WIDTH = 800
HEIGHT = 600

scale = 2
cs = 16*scale

blocks = {}

camera = {
	x = 0,
	y = 0,

	update = function(player)
		camera.x = player.x - (WIDTH/2)
		camera.y = player.y - (HEIGHT/2)
	end
}