local LifeHud = {
	x = 0,
	y = 0,
	w = 100,
	h = 10,
	value = 100,
	color = {255,0,0,255},
	max = nil
}

LifeHud.__index = LifeHud

function LifeHud.new(x,y,max)
	local self = setmetatable({},LifeHud)
	self.x = x
	self.y = y
	self.max = max

	return self
end

function LifeHud:draw()
	local size = self.max/10
	local number = self.value/size
	love.graphics.setColor(self.color)
	for i=0,number do
		love.graphics.rectangle("fill",self.x+i*size,self.y,size*10,size)

	end
end

function LifeHud:update(vie)
	self.value = vie
end

return LifeHud

