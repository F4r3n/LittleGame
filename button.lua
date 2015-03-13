
local Button = {
	x=0,
	y=0,
	w=150,
	h = 30,
	name=nil,
	box = nil,
	f = nil
}

Box = require('box')

Button.__index = Button

function Button.new(x,y,name,f,h,w)
	local self = setmetatable({},Button)
	self.x = x
	self.y = y
	self.f = f
	self.h = h or self.h
	self.w = w or self.w
	self.name = name
	self.box = Box.new(self.x,self.y,self.w,self.h)
	return self
end

function Button:draw()
	love.graphics.setColor(redBlood)
	love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
	love.graphics.setColor(black)
	love.graphics.print(self.name,self.x+self.w/3,self.y+5)

end

function Button:update(dt)

end

function Button:activate()
	self.f()
end



return Button
