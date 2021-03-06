local Enemy = {
	boxX,
	boxY,
	life=50,
	dmg=5,
	x = 0,
	y = 0,
	w = 20,
	h = 40,
	vx = 0,
	vy = 0,
	speed = 1,
	dead = false,
	weapon = nil,
	coolDown = 0,
	owner = 1,
	dirPlayer = 0,
	isBlocked = false,
	current_quad = nil,
	current_img = nil,
	animationCoolDown = 0.2,
	animationTime = 0,
	indexQuad = 2,
	score = 10

}

Enemy.__index = Enemy
Box = require 'box'
Rifle  = require 'rifle'

function Enemy.new(x,y)
	local self =setmetatable({},Enemy)
	self.x = x
	self.y = y
	self.boxY = Box.new(self.x,self.y,self.w,self.h)
	self.boxX = Box.new(self.x-10,self.y+10,self.w+20,self.h-20)
	self.weapon = Rifle.new(self.boxX.x+self.w,self.boxX.y-self.h/2+10)
	self.current_img = zs_image
	self.current_quad = zs[1]
	return self
end

function Enemy:draw()
	love.graphics.setColor(white)
	love.graphics.draw(zs_image,self.current_quad,self.boxY.x,self.boxY.y-18,0,self.dirPlayer*1.2,1*1.2,0,0)
end

function Enemy:move(dt,level)
	if level.player.boxX.x -self.boxX.x < 0 then
		self.dirPlayer = -1
	else self.dirPlayer = 1
	end
	self.vx = self.speed*self.dirPlayer
	if self.isBlocked ==true and self.jumping == false then
		self.vy = -self.speed*3
		self.isBlocked = false
		self.jumping = true
	end

end

function Enemy:update(dt,level)
	self.animationTime = self.animationTime + dt
	self.coolDown = self.coolDown + dt
	self:move(dt,level)

	if self.animationTime > self.animationCoolDown then
		self.indexQuad = (self.indexQuad + 1)%#zs
		if self.indexQuad == 0 then
			self.indexQuad = 2
		end
		self.current_quad = zs[self.indexQuad]
		self.animationTime = 0
	end

	local left =math.floor(self.boxX.x/level.w)-5
	local right =math.floor(self.boxX.x/level.w)+5
	local up = math.floor(self.boxX.y/level.h)-5
	local down = math.floor(self.boxX.y/level.h)+5
	if left <=1 then left = 1 end
	if right >#level.cases[1] then right = #level.cases[1] end
	if up <=1 then up=1 end
	if down>#level.cases then down = #level.cases end

	for i=up,down do
		for j=left,right do
			local case = level.cases[i][j]
			local b = Box.copy(case.box)
			b.x = b.x - self.vx
			b.y = b.y - self.vy

			if case.t == 1 or case.t ==-1 or case.t==3 then
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

					self.isBlocked = true
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

	if math.abs(level.player.boxX.x - self.boxX.x) < 400 then

		local dir = 0
		if level.player.boxX.x -self.boxX.x < 0 then
			dir = 180
		else dir = 0
		end
		if self.coolDown >1 then
			self.weapon:shot(dir,self,level,nil,nil)
			self.coolDown = 0
		end
	end


	self.vy = self.vy + gravity*dt
	self.boxX.x = self.boxX.x + self.vx
	self.boxX.y = self.boxX.y + self.vy

	self.boxY.x = self.boxY.x + self.vx
	self.boxY.y = self.boxY.y + self.vy


end


function Enemy:dommaged(d)

	self.life = self.life - d
	if self.life <= 0 then
		self.dead = true
	end
end

return Enemy


