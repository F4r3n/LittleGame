
local Rifle = {
	ammoMax = 1000,
	spread = 1,
	x = 0,
	y = 0,
	ammo = 100,
	bullets = {},
	coolDown = 0.1,
	name = "Rifle",
	shape =nil,
	radius = 0,
	img = nil,
	quad_img = nil,
	weapon = nil,
	dmg = 10,
	factorReload = 4
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
	self.img = rifle_image
	self.quad_img = rifle_quad
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
	self.ammo = self.weapon.ammo
end

function Rifle:update()
	self.ammo = self.weapon.ammo
end

function Rifle:reload(v)
	return self.weapon:reload(v)
end


function Rifle:activate(p)
	p.weapon = self	
end

return Rifle
