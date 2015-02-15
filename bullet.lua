local Bullet = {
	dmg = 10,
	speed = 100,
	owner = 0,
	dirX = 0,
	dirY = 0,
	x = 0,
	y = 0,
	vx = nil,
	vy = nil,
	w = 5,
	h = 5
}
Bullet.__index = Bullet
function Bullet.new(owner,x,y,dirX,dirY)
	local self = setmetatable({},Bullet)
	self.owner = owner
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY

	return self
end

function Bullet:draw(x,y)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",self.x+x,self.y+y,self.w,self.h)
end

function Bullet:update(dt)
	self.x = self.x + self.speed * self.dirX * dt
	self.y = self.y + self.speed * self.dirY * dt
end

return Bullet
