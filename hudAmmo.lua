
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
	local size = (5+20/self.value)/5
	local number = self.value/(size)
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill",self.x+(size*2+1),self.y,size*2*self.value,20)

end

function HudAmmo:update(ammo)
	self.value = ammo
end

return HudAmmo

