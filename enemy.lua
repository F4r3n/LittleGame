local Enemy = {
	boxX,
	boxY,
	life=50,
	dmg=5,
	x = 0,
	y = 0,
	w = 40,
	h = 40,
	vx = 0,
	vy = 0,
	speed = 20,
	dead = false

}

Enemy.__index = Enemy
Box = require 'box'

function Enemy.new(x,y)
	local self =setmetatable({},Enemy)
	self.x = x
	self.y = y
	self.boxY = Box.new(self.x,self.y,self.w,self.h)
	self.boxX = Box.new(self.x-5,self.y+5,self.w+10,self.h-10)

	return self
end

function Enemy:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("fill",self.boxY.x,self.boxY.y,self.boxY.w,self.boxY.h)
end

function Enemy:update(dt,level,x,y)

	for i=1,#level.cases do
		for j=1,#level.cases[i] do
			local case = level.cases[i][j]
			if case.t == 1 or case.t ==-1 then
				if self.boxY:AABB(case.box) then
					self.vy = -10
					jump = false
				end
				if self.boxX:AABB(case.box) then
					if self.boxX.x + self.boxX.w/2 - case.box.x > 5 then
						self.vx = self.speed*dt*4

					elseif case.box.x + case.box.w > self.boxX.x+5 then
						self.vx = -self.speed*dt*4
					end

				end


			end
		end
	end

	self.vy = self.vy + gravity*dt*10
	self.boxX.x = self.boxX.x + self.vx*dt +x
	self.boxX.y = self.boxX.y + self.vy*dt +y

	self.boxY.x = self.boxY.x + self.vx*dt +x
	self.boxY.y = self.boxY.y + self.vy*dt +y


end


function Enemy:dommaged(d)
	self.life = self.life - d
	if self.life <= 0 then
		self.dead = true
	end
end

return Enemy


