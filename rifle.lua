
local Rifle = {
	ammoMax = 1000,
	spread = 1,
	x = 0,
	y = 0,
	ammo = 1000,
	bullets = {},
	coolDown = 0.1,
	name = "Rifle",
	shape =nil,
	radius = 0,
	weapon = nil
}

Rifle.__index = Rifle
Bullet = require 'bullet'
BulletShape = require 'bulletShape'
MissileShape = require 'missileShape'
require('camera')
Weapon = require 'weapon'


function Rifle.new(x,y)
	local self = setmetatable({},Rifle)
	self.x = x
	self.y = y
	self.shape = BulletShape.new(5,5)
	self.weapon = Weapon.new(x,y)
	self.weapon:init(self)
	self.weapon.radius = self.radius
	return self
end

function Rifle:draw(s,x,y)
	self.weapon:draw(s,x,y)
end

function Rifle:shot(rad,p,level,x,y,dir)
	self.weapon:shot(rad,p,level,x,y,dir)
end



return Rifle
