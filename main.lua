
local Game = require 'game'

keyBoardInput = {}
gravity = 10
width = 800
height = 600
black = {0,0,0,255}
white = {255,255,255,255}

function love.load()
	love.window.setMode(width,height)
	love.window.setTitle("Yop");
	love.graphics.setBackgroundColor({0,0,0,255});
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
	if key == "p" then
		game = Game.new()
	end


	if key == "l" then
		game:reload()
	end
end


function love.keyreleased(key)
	keyBoardInput[key] = false
end
