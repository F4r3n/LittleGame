local Shotgun = {
	ammoMax = 1000,
	spread = 20,
	x = 0,
	y = 0,
	ammo = 1000,
	bullets = {},
	coolDown = 1,
	name = "Shotgun",
	shape = nil,
	radius = 15,
	weapon =nil
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
	self.shape = BulletShape.new(5,5)
	self.weapon = Weapon.new(x,y)
	self.weapon:init(self)
	return self
end

function Shotgun:draw(s,x,y)
	self.weapon:draw(s,x,y)
end

function Shotgun:shot(rad,p,level,x,y,dir)
	self.weapon:shot(rad,p,level,x,y,dir)
end



return Shotgun
