
local HudAmmo = {
	x = 0,
	y = 0,
	w = 200,
	h = 10,
	value = 100,
	color = black,
	max = nil
}

HudAmmo.__index = HudAmmo

function HudAmmo.new(x,y,max)
	local self = setmetatable({},HudAmmo)
	self.x = x
	self.y = y
	self.max = max
	self.color=black

	return self
end

function HudAmmo:draw()
	local r = self.w/self.value
	local size = (5+20/self.value)
	local number = self.value/(size)

	love.graphics.setColor(black)
	love.graphics.setColor(self.color)
	for i=0,self.value-1 do
		love.graphics.rectangle("fill",self.x+i*(size*2+5),self.y,size*2,20)

	end
end

function HudAmmo:update(ammo)
	self.value = ammo
end

return HudAmmo
