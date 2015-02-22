local Hud = {
	lifeHud = nil
}

Hud.__index = Hud
LifeHud = require 'lifeHud'

function Hud.new()
	local self = setmetatable({},Hud)
	self.lifeHud = LifeHud.new(10,10)
	return self
end

function Hud:draw()
	self.lifeHud:draw()
end

function Hud:update(dt,level)
	self.lifeHud:update(level.player.life)
end

return Hud
