local Shotgun = {
	ammoMax = 1000,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 1000,
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

function Shotgun:draw(s,x,y)
	love.graphics.setColor(black)

	if s== 0 then
		love.graphics.rectangle("fill",x+40,y,20,20)
	else
		love.graphics.rectangle("fill",x-10,y,20,20)
	end
end

function Shotgun:shot(rad,p,level,x,y)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=0,self.spread do
		local b = Bullet.new(p,p.boxX.x,p.boxX.y,math.random(rad-15,rad+15),5,self.shape,p.boxX.x,p.boxY.y)
		table.insert(level.bullets,b)
		camera:addLayer(1,b)
	end
end



return Shotgun
