local LifeHud = {
	x = 0,
	y = 0,
	w = 100,
	h = 10,
	value = 100,
	color = {255,0,0,255}
}

LifeHud.__index = LifeHud

function LifeHud.new(x,y)
	local self = setmetatable({},LifeHud)
	self.x = x
	self.y = y
	return self
end

function LifeHud:draw()
	local size = 20
	local number = self.value/size
	love.graphics.setColor(self.color)
	for i=0,number do
		love.graphics.rectangle("fill",self.x+i*size,self.y,size,size)

	end
end

function LifeHud:update(vie)
	self.value = vie
end

return LifeHud

