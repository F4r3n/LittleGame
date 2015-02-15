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
	jump = false,
	initX = 400,
	initY = 400,
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

	self.boxX = Box.new(self.initX-5,self.initY+5,self.w+10,self.h-10)
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
	if keyBoardInput["d"] then
		self.vx = self.speed
	end

	if keyBoardInput["right"] then
		table.insert(level.bullets,Bullet.new(0,self.initX,self.initY,1,0))
	end

	if keyBoardInput["left"] then
		table.insert(level.bullets,Bullet.new(0,self.initX,self.initY,-1,0))
	end
	if keyBoardInput["up"] then
		table.insert(level.bullets,Bullet.new(0,self.initX,self.initY,0,-1))
	end

	if keyBoardInput["down"] then
		table.insert(level.bullets,Bullet.new(0,self.initX,self.initY,0,1))
	end

	if keyBoardInput["q"] then
		self.vx = -self.speed
	end

	if keyBoardInput["s"] then
		self.vy = self.speed
	end

	if keyBoardInput[" "] and jump == false then
		self.vy = -self.speed
		jump = true
	end
	
--	self.x = self.x + self.vx*dt
--	self.y = self.y + self.vy*dt
--	print(self.x)
--	print(self.vx)


	for i=1,#level.cases do
		for j=1,#level.cases do
			local case = level.cases[i][j]
			if case.t == 1 then

				if self.boxY:AABB(case.box) then
		--			print(case.box.y,self.y+self.h)
					local d =(self.boxY.y+self.boxY.h)-case.box.y
					self.vy = -gravity*dt*2
					jump = false
				end
				--		if self.boxX:AABB(case.box) then
				---			print(case.box.x + case.box.w - self.boxX.x-5)
				---			if self.boxX.x + self.boxX.w - case.box.x > 5 then
				--	self.vx = 0
				--	self.x = self.x-5
				--				print("r")

				--			end
				--			if case.box.x + case.box.w > self.boxX.x+5 then
				--	self.vx = 0
				--	self.x = self.x+5
				--				print("l")
				--			end

				--		end


			end
		end
	end
	self.vx = self.vx*0.7*(1-dt)
	self.vy = self.vy + gravity*dt


end

function Player:moveUpdate()
	self.boxX.x = self.x-5
	self.boxX.y = self.y+5
	self.boxY.x = self.x
	self.boxY.y = self.y
end

return Player
