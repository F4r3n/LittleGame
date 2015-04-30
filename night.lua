local Night = {
	color = {0,0,0,0},
	time = 50,
	canvas = nil,
	torch = nil
}

Night.__index = Night

Torch = require 'torch'
function Night.new(color,torch)
	local self = setmetatable({}, Night)
	self.color = color
	self.canvas = love.graphics.newCanvas()
	self.torch = torch
	love.graphics.setCanvas(self.canvas)

	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill",0,0,width,height)

	love.graphics.setCanvas()
	return self
end

function Night:update(dt,x,y)
	self.torch:update(dt,x,y)
end

function Night:draw()

	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(self.color)
	love.graphics.setBlendMode("multiplicative")
	love.graphics.setCanvas()


	love.graphics.setColor(self.torch.color)
	love.graphics.draw(self.torch.canvas)

	love.graphics.setBlendMode("additive")
	love.graphics.setColor(self.color)
	love.graphics.draw(self.canvas)

	love.graphics.setBlendMode("alpha")

end

return Night
