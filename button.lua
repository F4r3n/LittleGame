
local Button = {
	x=0,
	y=0,
	w=150,
	h = 30,
	name=nil,
	box = nil,
	f = nil,
	isActivated = false,
	hover = false
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
	if self.hover then
		love.graphics.setLineWidth( 3 )

		love.graphics.setColor(black)
		love.graphics.rectangle("line",self.x*width,self.y*height,self.w,self.h)
	end

	love.graphics.setColor(redBlood)
	love.graphics.rectangle("fill",self.x*width,self.y*height,self.w,self.h)
	love.graphics.setColor(black)
	love.graphics.print(self.name,self.x*width+self.w/3,self.y*height+5)
end

function Button:update(dt,x,y)
	self.box.x = self.x*width
	self.box.y = self.y*height
	if self.box:pointInside(x,y) then
		self.hover = true
		if mouseLeftReleased then
			self:activate()
		end
	else self.hover = false
	end

end


function Button:activate()

	if self.isActivated == false then
		self.isActivated = true else self.isActivated = false end
		self.f()
	end



	return Button
