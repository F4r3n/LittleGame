local Shotgun = {
	ammoMax = 10,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 10,
	bullets = {},
	coolDown = 1,
	name = "Shotgun",
	shape =nil
}

Shotgun.__index = Shotgun
Bullet = require 'bullet'
BulletShape = require 'bulletShape'
MissileShape = require 'missileShape'
require('camera')


function Shotgun.new(x,y)
	local self = setmetatable({},Shotgun)
	self.x = x
	self.y = y
	self.shape = BulletShape.new(5,5)
	return self
end

function Shotgun:draw(s)
	love.graphics.setColor(black)

	if s== 0 then
		love.graphics.rectangle("fill",self.x + 5,self.y+5,20,20)
	else
		love.graphics.rectangle("fill",self.x - 55,self.y+5,20,20)
	end
end

function Shotgun:shot(rad,level)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=0,self.spread do
		local b = Bullet.new(0,self.x,self.y,math.random(rad-20,rad+20),5,self.shape)
		table.insert(level.bullets,b)
		camera:addLayer(0,b)
	end
end


return Shotgun
