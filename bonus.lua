local Bonus = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 10,
	h = 10,
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
	love.graphics.setColor(255,100,100,255)
	love.graphics.circle("fill",self.x,self.y,self.w,10)


end

function Bonus:update(dt)
end

return Bonus
