
local Rifle = {
	ammoMax = 1000,
	spread = 1,
	x = 0,
	y = 0,
	ammo = 1000,
	bullets = {},
	coolDown = 0.1,
	name = "Rifle",
	shape =nil
}

Rifle.__index = Rifle
Bullet = require 'bullet'
BulletShape = require 'bulletShape'
MissileShape = require 'missileShape'
require('camera')


function Rifle.new(x,y)
	local self = setmetatable({},Rifle)
	self.x = x
	self.y = y
	self.shape = BulletShape.new(5,5)
	return self
end

function Rifle:draw(s,x,y)
	love.graphics.setColor(black)

	if s== 0 then
		love.graphics.rectangle("fill",x+40,y,20,20)
	else
		love.graphics.rectangle("fill",x-10,y,20,20)
	end
end

function Rifle:shot(rad,p,level,x,y)
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



return Rifle
