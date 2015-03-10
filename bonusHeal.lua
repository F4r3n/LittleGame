
local BonusHeal = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 5,
	h = 5,
	box,
	dead = false,
	xb,
	yb,
	img = nil
}

BonusHeal.__index = BonusHeal
Box = require 'box'

function BonusHeal.new(x,y,xb,yb)
	local self = setmetatable({},BonusHeal)
	self.x = x
	self.y = y
	self.xb = xb
	self.yb = yb
	self.img = bonus_heal_image
	self.box = Box.new(self.xb,self.yb,self.w,self.h)
	return self
end

function BonusHeal:draw()
	love.graphics.setColor(white)
	love.graphics.draw(self.img,self.x-10,self.y-10)
end

function BonusHeal:action(player)
	return player:gainLife(10)
end

function BonusHeal:update(dt)
end

return BonusHeal
