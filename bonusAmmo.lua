local BonusAmmo = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 5,
	h = 5,
	box,
	dead = false,
	img = nil
}

BonusAmmo.__index = BonusAmmo
Box = require 'box'

function BonusAmmo.new(x,y)
	local self = setmetatable({},BonusAmmo)
	self.x = x
	self.y = y
	self.img = bonus_ammoBox_image
	self.box = Box.new(self.x,self.y,self.w,self.h)
	return self
end

function BonusAmmo:draw()
	love.graphics.setColor(white)
	love.graphics.draw(self.img,self.x-15,self.y-20,0,1.5,1.5)
end

function BonusAmmo:action(player)
	return player:gainAmmo(10)
end

function BonusAmmo:update(dt)
end

return BonusAmmo
