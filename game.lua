local Game = {
	player = nil,
	level = nil
}

Game.__index = Game;

local Player = require 'player'
local Level = require 'level'

function Game.new() 
	local self = setmetatable({},Game)
	self.player = Player.new({400,400})
	self.level = Level.new(1,self.player)
	return self
end

function Game:reload()
	self.level:reload()
end

function Game:draw()
	self.level:draw()
end

function Game:update(dt)
	self.level:update(dt)
end

return Game;
