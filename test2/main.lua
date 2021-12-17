--main

require 'global'
local map = require 'map'
local p = require 'player'

function love.update(dt)
	p.update(map.getmap())
	camera.update(p.getplayer())
end

function love.draw()
	map.draw()
	p.draw()
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 0)
end
