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
	self.boxX = Box.new(self.x-10,self.y+10,self.w+20,self.h-20)

	return self
end

function Enemy:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("fill",self.x,self.y,self.boxY.w,self.boxY.h)
end

function Enemy:update(dt,level)

	for i=1,#level.cases do
		for j=1,#level.cases[i] do
			local case = level.cases[i][j]
			local b = Box.copy(case.box)
			b.x = b.x - self.vx
			b.y = b.y - self.vy

			if case.t == 1 or case.t ==-1 then
				if self.boxY:AABB(b) then
					local bottomSide = math.abs(b.h + b.y - (self.boxY.y + self.boxY.h/2))
					local topSide = math.abs(-b.y + self.boxY.y + self.boxY.h/2)
					if topSide < bottomSide then
						local d =(self.boxY.y+self.boxY.h)-b.y
						self.vy = self.vy-d
						self.jumping = false
					else
						local d = math.abs(b.y + b.h - self.boxY.y + 1)
						self.vy = self.vy + d

					end
				end
				if self.boxX:AABB(b) then
					local leftSide = math.abs(b.w + b.x - (self.boxX.x+self.boxX.w/2))
					local rightSide = math.abs(-b.x+self.boxX.x + self.boxX.w/2)  
					if leftSide > rightSide  then
						local c =math.abs((self.boxX.x+self.boxX.w)-(b.x)+1)
						self.vx = self.vx-c

					else
						local c =math.abs(b.x+b.w-self.boxX.x+1)
						self.vx = self.vx+c
					end

				end


			end
		end
	end

	self.vy = self.vy + gravity*dt
	self.boxX.x = self.boxX.x + self.vx*dt
	self.boxX.y = self.boxX.y + self.vy*dt

	self.boxY.x = self.boxY.x + self.vx*dt
	self.boxY.y = self.boxY.y + self.vy*dt

	self.x = self.x + self.vx*dt
	self.y = self.y + self.vy*dt


end


function Enemy:dommaged(d)

	self.life = self.life - d
	if self.life <= 0 then
		self.dead = true
	end
end

return Enemy


