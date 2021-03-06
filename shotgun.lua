local Shotgun = {
	ammoMax = 10,
	spread = 15,
	x = 0,
	y = 0,
	ammo = 10,
	bullets = {},
	coolDown = 1,
	name = "Shotgun",
	shape = nil,
	radius = 15,
	img = nil,
	quad_img = nil,
	weapon =nil,
	dmg = 5,
	factorReload = 1

}

Shotgun.__index = Shotgun
Bullet = require 'bullet'
BulletShape = require 'bulletShape'
MissileShape = require 'missileShape'
Weapon = require 'weapon'


function Shotgun.new(x,y)
	local self = setmetatable({},Shotgun)
	self.x = x
	self.y = y
	self.img = shotgun_image
	self.quad_img = shotgun_quad
	self.shape = BulletShape.new(5,5)
	self.weapon = Weapon.new(x,y)
	self.weapon:init(self)
	return self
end

function Shotgun:draw(s,x,y)
	self.weapon:draw(s,x,y)
end

function Shotgun:update()
	self.ammo = self.weapon.ammo
end

function Shotgun:shot(rad,p,level,x,y)
	self.weapon:shot(rad,p,level,x,y)
	self.ammo = self.weapon.ammo
end

function Shotgun:reload(v)
	return self.weapon:reload(v)
end

function Shotgun:activate(p)
	p.weapon = self	
end



return Shotgun
