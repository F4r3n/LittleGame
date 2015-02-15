local Bonus = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 10,
	h = 10,
	box
}

Bonus.__index = Bonus
Box = require 'box'

function Bonus.new(x,y)
	local self = setmetatable({},Bonus)
	self.x = x
	self.y = y
	self.box = Box.new(x,y,w,h)
	return self
end

function Bonus:draw()
	love.graphics.setColor(255,100,100,255)
	love.graphics.circle("fill",self.box.x,self.box.y,self.w,5)
end

function Bonus:update(dt,x,y)
	self.box.x = self.box.x+x
	self.box.y = self.box.y+y
end

return Bonus
