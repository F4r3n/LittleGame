
local Torch = {
	color = {0,0,0,0},
	x = 0,
	y = 0,
	canvas = nil
}

Torch.__index = Torch

function Torch.new(color)
	local self = setmetatable({}, Torch)
	self.color = color

	self.canvas = love.graphics.newCanvas()
	love.graphics.setCanvas(self.canvas)

	love.graphics.setColor(self.color)
	love.graphics.circle("fill",self.x,self.y,100,100)

	love.graphics.setCanvas()
	return self
end

function Torch:update(dt,x,y)
	self.x = x
	self.y = y

	self.canvas:clear()
	love.graphics.setCanvas(self.canvas)

	love.graphics.setColor(self.color)
	love.graphics.circle("fill",self.x,self.y,100,100)

	love.graphics.setCanvas()
end

function Torch:draw()

	
end

return Torch
