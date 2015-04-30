
local Torch = {
	color = {0,0,0,0},
	x = 0,
	y = 0,
	canvas = nil,
	shader
}

Torch.__index = Torch

function Torch.new(color)
	local self = setmetatable({}, Torch)
	self.color = color

	self.shader = love.graphics.newShader[[
	vec4 love_SreenSize;
	vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
		vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color


		return pixel * vec4(color.r,color.g,color.b,color.a);
	}
	]]
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
	love.graphics.setShader(self.shader)
	love.graphics.setColor(self.color)
	love.graphics.circle("fill",self.x,self.y,100,100)

	love.graphics.setShader()
	love.graphics.setCanvas()
end

function Torch:draw()


end

return Torch
