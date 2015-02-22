local Player = {
	x = 0,
	y = 0,
	w = 30,
	h = 30,
	vx = 0,
	vy = 0,
	speed = 10,
	boxY = nil,
	boxX = nil,
	jumping = false,
	initX = 400,
	initY = 400,
	coolDown = 0.1,
	time = 0,
	dead = false,
	life = 100,
	immortal = 1,
	timeImmortal =0,
	mortal = true,
	maxLife = 100
}

Box = require 'box'
Bullet = require 'bullet'

Player.__index = Player;

function Player.new(position) 
	local self = setmetatable({},Player);
	self.x = position[1]
	self.y = position[2]
	self.initX = position[1]
	self.initY = position[2]

	self.boxX = Box.new(self.initX-10,self.initY+10,self.w+20,self.h-20)
	self.boxY = Box.new(self.initX,self.initY,self.w,self.h)
	return self
end

function Player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", self.initX, self.initY, self.w, self.h)

	love.graphics.setColor(0,100,0)
	love.graphics.rectangle("fill", self.boxX.x, self.boxX.y, self.boxX.w, self.boxX.h)

	love.graphics.setColor(0,0,100)
	love.graphics.rectangle("fill", self.boxY.x, self.boxY.y, self.boxY.w, self.boxY.h)

end

function Player:update(dt,level)
	self.time = self.time+dt
	self.timeImmortal = self.timeImmortal + dt

	if self.timeImmortal > self.immortal then
		self.mortal = true
		self.timeImmortal =0
	end


	if keyBoardInput["d"] then
		self.vx = self.speed
	end
	if self.time > self.coolDown then
		if keyBoardInput["right"] then
			local b = Bullet.new(0,self.initX,self.initY,1,0,5)
			self.time = 0
			table.insert(level.bullets,b)
			camera:addLayer(1,b)

		elseif keyBoardInput["left"] then

			local b = Bullet.new(0,self.initX,self.initY,-1,0,5)
			self.time = 0
			table.insert(level.bullets,b)
			camera:addLayer(1,b)
		elseif keyBoardInput["up"] then

			local b = Bullet.new(0,self.initX,self.initY,0,-1,5)
			self.time = 0
			table.insert(level.bullets,b)
			camera:addLayer(1,b)

		elseif keyBoardInput["down"] then
			local b = Bullet.new(0,self.initX,self.initY,0,1,5)
			self.time = 0
			table.insert(level.bullets,b)
			camera:addLayer(1,b)
		end
	end

	if keyBoardInput["q"] then
		self.vx = -self.speed
	end


	if keyBoardInput[" "] and self.jumping == false then
		self.vy = -self.speed*(2/3)
		self.jumping = true
	end


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
	self.vx = self.vx*0.7*(1-dt)
	self.vy = self.vy + gravity*dt


end

function Player:dommaged(d)
	if self.mortal == true and self.dead == false then
		self.life = self.life -d
		self.mortal = false
	end
	if self.life <=0 then 
		self.dead = true
	end
end

function Player:gainLife(l)
	if self.life < self.maxLife then
		self.life = self.life +l
		if self.life > self.maxLife then
			self.life = self.maxLife
		end
	end
end

function Player:moveUpdate()
	self.boxX.x = self.x-5
	self.boxX.y = self.y+5
	self.boxY.x = self.x
	self.boxY.y = self.y
end

return Player
