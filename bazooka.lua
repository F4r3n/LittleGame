local Bazooka = {
	x = 0,
	y = 0,
	name = "Bazooka",
	ammo = 3,
	maxAmmo = 3
}

Bazooka.__index = Bazooka
MissileShape = require 'missileShape'

function Bazooka.new(x,y)
	local self = setmetatable({}, Bazooka)
	self.x = x
	self.y = y
	self.shape = MissileShape.new(20,10)
	return self
end

function Bazooka:draw()
	love.graphics.setColor(black)

	if s== 0 then
	love.graphics.rectangle("fill",self.x + 5,self.y+5,20,20)
else
	love.graphics.rectangle("fill",self.x - 55,self.y+5,20,20)

end

end

function Bazooka:shot(rad,level)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=0,self.spread do
		table.insert(level.bullets,Bullet.new(0,self.x,self.y,math.random(rad-20,rad+20),5,self.shape))
	end
end

return Bazooka
