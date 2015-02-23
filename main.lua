
local Game = require 'game'

keyBoardInput = {}
gravity = 10
width = 800
height = 600
black = {0,0,0,255}
white = {255,255,255,255}

function love.load()
	love.window.setMode(width,height)
	love.window.setTitle("Little Game");
	love.graphics.setBackgroundColor({0,0,0,255});

	local img = love.graphics.newImage('blood.png');

	p = love.graphics.newParticleSystem(img, 5);
	p:setParticleLifetime(0.1, 0.2); -- Particles live at least 2s and at most 5s.
	p:setSizeVariation(1);
	p:setEmissionRate(10);
	p:setEmitterLifetime(0.2)
	p:setLinearAcceleration(-10, -10, 10, 10); -- Random movement in all directions.
	p:setColors(255, 255, 255, 255, 255, 255, 255, 0); -- Fade to black.
	p:stop()
	game = Game.new();
end

function love.update(dt)
	game:update(dt)
end


function love.draw()
	game:draw()
end

function love.keypressed(key,isrepeat)
	keyBoardInput[key] = true

	if key == "l" then
		love.load()
	end
end


function love.keyreleased(key)
	keyBoardInput[key] = false
end
