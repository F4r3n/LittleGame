local TimeHud = {
	x=0,
	y=0,
	time = 0
}

TimeHud.__index = TimeHud

function TimeHud.new(x,y)
	local self  = setmetatable({}, TimeHud)
	self.x = x
	self.y = y
	return self
end

function TimeHud:draw()
	love.graphics.setColor(white)
	love.graphics.print("Time ".. math.floor(self.time+0.5),self.x*width,self.y*height)
end

function TimeHud:update(time)
	self.time = self.time + time
end

return TimeHud

