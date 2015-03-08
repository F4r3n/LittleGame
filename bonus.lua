local Bonus = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 5,
	h = 5,
	box,
	dead = false,
	xb,
	yb
}

Bonus.__index = Bonus
Box = require 'box'

function Bonus.new(x,y,xb,yb)
	local self = setmetatable({},Bonus)
	self.x = x
	self.y = y
	self.xb = xb
	self.yb = yb
	self.box = Box.new(self.xb,self.yb,self.w,self.h)
	return self
end

function Bonus:draw()
	love.graphics.setColor(white)
	love.graphics.draw(bonus_heal_image,self.x-10,self.y-10)


end

function Bonus:update(dt)
end

return Bonus
