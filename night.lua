local Night = {
	color = {0,0,0,0},
	time = 50
}

Night.__index = Night

function Night.new(color)
	local self = setmetatable({}, Night)
	self.color = color
	return self
end

function Night:update(dt)
	self.time = self.time+dt/100
	local c = math.abs(math.sin(self.time)*200)+50
	self.color = {c,c,c,100}
end

function Night:draw()

	love.graphics.setBlendMode("multiplicative")
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill",0,0,width,height)
	love.graphics.setBlendMode("alpha")
end

return Night
