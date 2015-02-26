local Bullet = {
	dmg = 10,
	speed = 500,
	owner = 0,
	dirX = 0,
	dirY = 0,
	x = 0,
	y = 0,
	vx = nil,
	vy = nil,
	w = 5,
	h = 5,
	box = nil,
	dead = false,
	shape = 0,
	xb = 0,
	yb = 0
}
Box = require 'box'
Bullet.__index = Bullet
function Bullet.new(owner,x,y,rad,dmg,shape,xb,yb)
	local self = setmetatable({},Bullet)
	self.owner = owner
	self.x = x
	self.y = y

	self.xb = x
	self.yb = y
	self.dirX = math.cos(rad*math.pi/180)
	self.dirY = math.sin(rad*math.pi/180)
	self.dmg = dmg
	self.box = Box.new(xb,yb,self.w,self.h)
	self.shape = shape

	return self
end

function Bullet:draw()
	self.shape:draw(self.x,self.y)
end

function Bullet:update(dt)
	self.box.x = self.box.x + self.speed * self.dirX * dt
	self.box.y = self.box.y + self.speed * self.dirY * dt
	self.x = self.x + self.speed * self.dirX*dt
	self.y = self.y + self.speed * self.dirY*dt

end



return Bullet
