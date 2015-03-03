
local Game = require 'game'

keyBoardInput = {}
mouseInput = {}
keyBoardInputRelease = {}
gravity = 10
width = 800
height = 600
black = {0,0,0,255}
white = {255,255,255,255}
blue = {0,0,255,255}
friction = 5
mousePressedLeft = false
mouseX = 0
mouseY = 0

function love.load()
	love.window.setMode(width,height)
	love.window.setTitle("Little Game");
	love.graphics.setBackgroundColor(blue);

	local img = love.graphics.newImage('blood.png');

	p = love.graphics.newParticleSystem(img, 100);
	p:setParticleLifetime(0.1,0.2); -- Particles live at least 2s and at most 5s.
	p:setSizeVariation(1);
	p:setEmissionRate(100);
	p:setEmitterLifetime(1)
	p:setLinearAcceleration(-100, -100, 100, 100); -- Random movement in all directions.
	p:setColors(255, 255, 255, 255, 255, 255, 255, 0); -- Fade to black.
	p:stop()
	game = Game.new();
end

function love.update(dt)

	if mousePressedLeft then
		mouseX,mouseY = love.mouse.getPosition()
	end
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

function love.mousepressed(x,y,button)
	if button == "l" then
		mousePressedLeft = true
	end
end


function love.mousereleased(x,y,button)
	if button == "l" then
		mousePressedLeft = false
	end
end


function love.keyreleased(key)
	keyBoardInput[key] = false
	keyBoardInputRelease[key] = true
end
