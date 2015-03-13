
local Button = {
	x=0,
	y=0,
	w=100,
	h = 30,
	name=nil

}

Button.__index = Button

function Button.new(x,y,name,h,w)
	local self = setmetatable({},Button)
	self.x = x
	self.y = y
	self.h = h or self.h
	self.w = w or self.w
	self.name = name
	return self
end

function Button:draw()
	love.graphics.setColor(redBlood)
	love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
	love.graphics.setColor(black)
	love.graphics.print(self.name,self.x+10,self.y+5)

end

function Button:update(dt)

end

return Button
