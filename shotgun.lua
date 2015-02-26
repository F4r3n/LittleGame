local Shotgun = {
	ammoMax = 10,
	spread = 1,
	x = 0,
	y = 0,
	ammo = 1000,
	bullets = {},
	coolDown = 0.1,
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

function Shotgun:shot(rad,p,level,x,y)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=0,self.spread do
		local b = Bullet.new(p,p.boxX.x,p.boxX.y,math.random(rad,rad),5,self.shape,p.boxX.x,p.boxY.y)
		table.insert(level.bullets,b)
		camera:addLayer(1,b)
	end
end


return Shotgun
