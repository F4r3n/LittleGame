
local Game = require 'game'

keyBoardInput = {}
gravity = 200

function love.load()
	love.window.setMode(600,800)
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
end


function love.keyreleased(key)
	keyBoardInput[key] = false
end
