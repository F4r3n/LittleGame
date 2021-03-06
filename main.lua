local Game = require 'game'
local Menu = require 'menu'
keyBoardInput = {}
mouseInput = {}
keyBoardInputRelease = {}
gravity = 10
WIDTH = 800
HEIGHT = 600
width = WIDTH
height = HEIGHT
black = {0,0,0,255}
white = {255,255,255,255}
blue = {0,0,255,255}
grey = {119,104,104,255}
redBlood = {200,25,25,255}
friction = 5
mousePressedLeft = false
mouseX = 0
mouseY = 0
FPS = 60
updateMax = 1/FPS
updateCurrent = 0
debugMode = false
play = false
mouseLeftReleased = false

require('profile')

zs_image = love.graphics.newImage('assets/zs.png')
zs = {
	love.graphics.newQuad(0,0,40,50,zs_image:getWidth(),zs_image:getHeight()),
	love.graphics.newQuad(40,0,30,50,zs_image:getWidth(),zs_image:getHeight()),
	love.graphics.newQuad(75,0,20,50,zs_image:getWidth(),zs_image:getHeight()),
	love.graphics.newQuad(100,0,22,50,zs_image:getWidth(),zs_image:getHeight()),
	love.graphics.newQuad(128,0,20,50,zs_image:getWidth(),zs_image:getHeight())
}


function love.load()
	if arg[2] == "-d" then 
		debugMode = true 
		print("Debug Mode")
	end
	cursor_red_cross = love.mouse.newCursor('assets/red_cross.png',10,10)
	cursor_white_cross = love.mouse.newCursor('assets/white_cross.png',10,10)
	cursor_build_cross_black = love.mouse.newCursor('assets/cross_build_black.png',10,10)
	shotgun_image = love.graphics.newImage('assets/shotgun.png')
	ball_image = love.graphics.newImage('assets/ball.png')
	bonus_heal_image = love.graphics.newImage('assets/bonus_heal.png')
	bonus_ammoBox_image = love.graphics.newImage('assets/ammoBox.png')
	rifle_image = love.graphics.newImage('assets/rifle.png')
	rifle_quad = love.graphics.newQuad(0,0,rifle_image:getWidth(),rifle_image:getHeight(),rifle_image:getWidth(),rifle_image:getHeight())

	shotgun_quad = love.graphics.newQuad(0,0,50,25,shotgun_image:getWidth(),shotgun_image:getHeight())

	grass_image = love.graphics.newImage('assets/grass.png')
	grass_quad = love.graphics.newQuad(5,0,25,30,grass_image:getWidth(),grass_image:getHeight())
	earth_image = love.graphics.newImage('assets/terre.png')
	earth_quad = love.graphics.newQuad(5,5,25,25,earth_image:getWidth(),earth_image:getHeight())
	rock_image = love.graphics.newImage('assets/rock.png')
	rock_quad = love.graphics.newQuad(5,5,25,25,rock_image:getWidth(),rock_image:getHeight())
	earth_batch = love.graphics.newSpriteBatch(earth_image,1000)
	rock_batch = love.graphics.newSpriteBatch(rock_image,1000)
	grass_batch = love.graphics.newSpriteBatch(grass_image,1000)

	z_image = love.graphics.newImage('assets/z2.png')
	z_quad = love.graphics.newQuad(0,0,50,50,z_image:getWidth(),z_image:getHeight())
	grid_img = love.graphics.newImage('assets/grid.png')
	grid_batch = love.graphics.newSpriteBatch(grid_img,8)

	love.window.setMode(width,height)
	love.window.setTitle("Little Game");
	love.graphics.setBackgroundColor(blue);


	loadParticles()
	love.mouse.setCursor(cursor_white_cross)
	game = Game.new();
	menu = Menu.new(game)
	print(love.graphics:getRendererInfo())

	if debugMode then
		profiler = newProfiler()
		profiler:start()
	end


end

function loadParticles()

	local img = love.graphics.newImage('assets/blood.png');
	p = love.graphics.newParticleSystem(img, 1000);
	p:setParticleLifetime(0.05,0.1); -- Particles live at least 2s and at most 5s.
	p:setSizeVariation(1);
	p:setEmissionRate(1000);
	p:setEmitterLifetime(1)
	p:setLinearAcceleration(-1000, -1000, 1000, 1000); -- Random movement in all directions.
	p:setColors(255, 255, 255, 255, 255, 255, 255, 0); -- Fade to black.
	p:stop()


end



function love.update(dt)
	--love.graphics.setBackgroundColor(blue);

	mx,my = love.mouse.getPosition()

	if dt > updateMax then dt = updateMax end
	updateCurrent = updateCurrent + dt

	while updateCurrent >= updateMax do
		updateCurrent = updateCurrent - updateMax

		mouseX,mouseY = love.mouse.getPosition()
		if play == true then
			game:update(dt)
		else menu:update(dt)
		end
	end
	mouseLeftReleased = false


end


function love.draw()
	--love.graphics.clear()

	if play ==  true then
		game:draw()
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, height-20)
	else menu:draw()
	end
end

function love.keypressed(key,scancode,isrepeat)
	keyBoardInput[key] = true
	if key == "p" then
		if play==false then
			play = true
		else play =false
		end
	end
end

function love.mousepressed(x, y, button, istouch)
	--print(button)
	if button == 1 then
		--print("test")
		mousePressedLeft = true
	end
end

function love.quit()
	print("Merci d'avoir joué")

	if debugMode then
		profiler:stop()

		local outfile = io.open( "profile.txt", "w+" )
		profiler:report( outfile )
		outfile:close()
	end

end


function love.mousereleased(x,y,button,istouch)
	if button == 1 then
		mousePressedLeft = false
		mouseLeftReleased = true
	end
end


function love.keyreleased(key)
	keyBoardInput[key] = false
	keyBoardInputRelease[key] = true
end
