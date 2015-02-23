local Shotgun = {
	ammoMax = 10,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 10,
	bullets = {},
	coolDown = 1
}

Shotgun.__index = Shotgun
Bullet = require 'bullet'


function Shotgun.new(x,y)
	local self = setmetatable({},Shotgun)
	self.x = x
	self.y = y
	return self
end

function Shotgun:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("fill",self.x + 5,self.y+5,20,20)
end

function Shotgun:shot(rad,level)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=0,self.spread do
		table.insert(level.bullets,Bullet.new(0,self.x,self.y,math.random(rad-20,rad+20),5))
	end
end

function Shotgun:update(dt,x,y)
	self.x = self.x + x
	self.y = self.y + y
end

return Shotgun
