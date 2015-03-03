local Weapon = {
	ammoMax = 1000,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 1000,
	bullets = {},
	coolDown = 0.1,
	name = "Weapon",
	shape =nil,
	radius = 0
}

Weapon.__index = Weapon
Bullet = require 'bullet'
BulletShape = require 'bulletShape'
MissileShape = require 'missileShape'


function Weapon.new(x,y)
	local self = setmetatable({},Weapon)
	self.x = x
	self.y = y
	self.shape = BulletShape.new(5,5)
	return self
end

function Weapon:init(w)
	self.ammoMax = w.ammoMax
	self.spread = w.spread
	self.x = w.x
	self.y = w.y
	self.ammo = w.ammo
	self.ammoMax = w.ammoMax
	self.coolDown = w.coolDown
	self.name = w.name
	self.shape = w.shape
	self.radius = w.radius

end

function Weapon:draw(s,x,y)
	love.graphics.setColor(black)

	if s== 0 then
		love.graphics.rectangle("fill",x+40,y,20,20)
	else
		love.graphics.rectangle("fill",x-10,y,20,20)
	end
end

function Weapon:shot(rad,p,level,x,y)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=1,self.spread do
		
		local b = Bullet.new(p,p.boxX.x,p.boxX.y,math.random(rad-self.radius,rad+self.radius),5,self.shape,p.boxX.x,p.boxY.y)
		table.insert(level.bullets,b)
		camera:addLayer(1,b)
	end
end



return Weapon
