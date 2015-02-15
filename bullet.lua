local Bullet = {
	dmg = 10,
	speed = 300,
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
}
Box = require 'box'
Bullet.__index = Bullet
function Bullet.new(owner,x,y,dirX,dirY,dmg)
	local self = setmetatable({},Bullet)
	self.owner = owner
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY
	self.dmg = dmg
	self.box = Box.new(self.x,self.y,self.w,self.h)

	return self
end

function Bullet:draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",self.box.x,self.box.y,self.w,self.h)
end

function Bullet:update(dt,x,y)
	self.box.x = self.box.x + self.speed * self.dirX * dt+x
	self.box.y = self.box.y + self.speed * self.dirY * dt+y
end



return Bullet
