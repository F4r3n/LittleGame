local Hud = {
	lifeHud = nil,
	score = nil,
	time = nil
}

Hud.__index = Hud
LifeHud = require 'lifeHud'
ScoreHud = require 'scoreHud'
TimeHud = require 'timeHud'

function Hud.new(level)
	local self = setmetatable({},Hud)
	self.lifeHud = LifeHud.new(10,10,level.player.maxLife)
	self.score = ScoreHud.new(width/2,10)
	self.time = TimeHud.new(width - 100,10)
	return self
end

function Hud:draw()
	self.lifeHud:draw()
	self.score:draw()
	self.time:draw()
end

function Hud:update(dt,level)
	self.lifeHud:update(level.player.life)
	self.score:update(0)
	self.time:update(dt)
end

return Hud
