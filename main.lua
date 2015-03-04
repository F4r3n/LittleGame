
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

	cursor_red_cross = love.mouse.newCursor('assets/red_cross.png',10,10)
	cursor_white_cross = love.mouse.newCursor('assets/white_cross.png',10,10)
	shotgun_image = love.graphics.newImage('assets/shotgun.png')
	shotgun_quad = love.graphics.newQuad(0,50,75,50,shotgun_image:getWidth(),shotgun_image:getHeight())
	grass_image = love.graphics.newImage('assets/grass.png')
	grass_quad = love.graphics.newQuad(5,0,25,30,grass_image:getWidth(),grass_image:getHeight())
	earth_image = love.graphics.newImage('assets/terre.png')
	earth_quad = love.graphics.newQuad(5,5,25,25,earth_image:getWidth(),earth_image:getHeight())
	rock_image = love.graphics.newImage('assets/rock.png')
	rock_quad = love.graphics.newQuad(5,5,25,25,rock_image:getWidth(),rock_image:getHeight())


	love.window.setMode(width,height)
	love.window.setTitle("Little Game");
	love.graphics.setBackgroundColor(blue);

	local img = love.graphics.newImage('assets/blood.png');

	p = love.graphics.newParticleSystem(img, 100);
	p:setParticleLifetime(0.1,0.2); -- Particles live at least 2s and at most 5s.
	p:setSizeVariation(1);
	p:setEmissionRate(100);
	p:setEmitterLifetime(1)
	p:setLinearAcceleration(-100, -100, 100, 100); -- Random movement in all directions.
	p:setColors(255, 255, 255, 255, 255, 255, 255, 0); -- Fade to black.
	p:stop()
	love.mouse.setCursor(cursor_white_cross)
	game = Game.new();
end

function love.update(dt)

	mouseX,mouseY = love.mouse.getPosition()
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
