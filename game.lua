local Game = {
	player = nil,
	level = nil,
	hud = nil,
	night
}

Game.__index = Game;

local Player = require 'player'
local Level = require 'level'
local Hud = require 'hud'

require('camera')

function Game.new() 
	local self = setmetatable({},Game)
	self.player = Player.new({200,100})
	self.level = Level.new(0,self.player)
	self.hud = Hud.new(self.level)
	camera:addLayer(1,self.level)


	return self
end

function Game:reload()
	self.level:reload()
end

function Game:draw()
	camera:simpleDraw()

	self.hud:draw()
end

function Game:update(dt)
	self.level:update(dt)
	self.hud:update(dt,self.level)
end

return Game;
