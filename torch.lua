
local Torch = {
	color = {0,0,0,0},
	x = 0,
	y = 0
}

Torch.__index = Torch

function Torch.new(color)
	local self = setmetatable({}, Torch)
	self.color = color
	return self
end

function Torch:update(dt,x,y)
	self.x = x
	self.y = y
end

function Torch:draw()

	love.graphics.setBlendMode("additive")
	love.graphics.setColor(self.color)
	love.graphics.circle("fill",self.x,self.y,100,100)
	love.graphics.setBlendMode("alpha")

end

return Torch
