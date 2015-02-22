local LifeHud = {
	x = 0,
	y = 0,
	w = 200,
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
	local r = self.w/self.value
	local size = 10
	local number = self.value/(size)
	print(r,size,number)

	love.graphics.setColor(black)
	love.graphics.rectangle("line",self.x,self.y,self.w,20)
	love.graphics.setColor(self.color)
	for i=0,number-1 do
		love.graphics.rectangle("fill",self.x+i*size*2,self.y,size*2,20)

	end
end

function LifeHud:update(vie)
	self.value = vie
end

return LifeHud

