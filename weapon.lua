local Weapon = {
	ammoMax = 1000,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 10,
	bullets = {},
	coolDown = 0.1,
	name = "Weapon",
	shape =nil,
	radius = 0,
	img = nil,
	quad_img = nil,
	w=nil

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
	self.w = w
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
	self.img = w.img
	self.quad_img = w.quad_img
end

function Weapon:reload(a)
	local v = a*self.w.factorReload
	if self.ammo ~=self.ammoMax then
		if self.ammo + v > self.ammoMax then
			self.ammo = self.ammoMax
		else self.ammo = self.ammo + v
		end
		self.w:update()
		return true
	else return false
	end
end

function Weapon:draw(s,x,y)

	if self.img == nil then
		love.graphics.setColor(white)

		if s== 0 then
			love.graphics.rectangle("fill",x+40,y,20,20)
		else
			love.graphics.rectangle("fill",x-10,y,20,20)
		end
	else 
		if s== 0 then
			love.graphics.draw(self.img,self.quad_img,x,y,0,1,1,0,0,0,0)

		else
			love.graphics.draw(self.img,self.quad_img,x+40,y,0,-1,1,0,0,0,0)
		end
	end
end

function Weapon:shot(rad,p,level,x,y)
	if self.ammo <=0 then 
		return
	end
	self.ammo = self.ammo - 1
	for i=1,self.spread do

		local b = Bullet.new(p,p.boxY.x+p.w/2,p.boxY.y+p.h/2,
							math.random(rad-self.radius,rad+self.radius),
							self.w.dmg,self.shape,p.
							boxY.x+p.w/2,p.boxY.y+p.h/2)
		table.insert(level.bullets,b)
		camera:addLayer(1,b)
	end
end



return Weapon
