local Shotgun = {
	ammoMax = 10,
	spread = 10,
	x = 0,
	y = 0,
	ammo = 10,
	bullets = {}
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

function Shotgun:shot()
	self.ammo = self.ammo - 1
	for i=0,spread do
		table.insert(self.bullets,Bullet.new(0,self.x,self.y,math.random(0,1),math.random(0,1)))
	end
end

function Shotgun:update(dt,x,y)
	self.x = self.x + x
	self.y = self.y + y
end

return Shotgun
