local Player = {
	x = 400,
	y = 400,
	w = 30,
	h = 30,
	vx = 0,
	vy = 0,
	speed = 200,
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

	self.boxX = Box.new(self.initX,self.initY+5,self.w+10,self.h-10)
	self.boxY = Box.new(self.initX,self.initY,self.w,self.h)
	return self
end

function Player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", self.initX, self.initY, self.w, self.h)


end

function Player:update(dt,level)
	if keyBoardInput["d"] then
		self.vx = self.speed
	end

	if keyBoardInput["right"] then
		table.insert(level.bullets,Bullet.new(0,self.x,self.y,1,0))
	end

	if keyBoardInput["q"] then
		self.vx = -self.speed
	end

	if keyBoardInput["s"] then
		self.vy = self.speed
	end

	if keyBoardInput[" "] and jump == false then
		self.vy = -self.speed*1.5
		jump = true
	end

	self.x = self.x + self.vx*dt
	self.y = self.y + self.vy*dt

	self:moveUpdate()

	for i=1,#level.cases do
		for j=1,#level.cases do
			local case = level.cases[i][j]
			if self.boxY:AABB(case.box) then
				if case.t == 1 then
					local d =(self.boxY.y+self.boxY.h)-case.box.y
					self.vy = 0
					self.y = self.y-(d)
					jump = false
				end
			end
		end
	end
	self:moveUpdate()
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
