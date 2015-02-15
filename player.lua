local Player = {
	x = 0,
	y = 0,
	w = 30,
	h = 30,
	vx = 0,
	vy = 0,
	speed = 100,
	boxY = nil,
	boxX = nil
}

Box = require 'box'

Player.__index = Player;

function Player.new(position) 
	local self = setmetatable({},Player);
	self.x = position[1]
	self.y = position[2]
	self.boxX = Box.new(self.x,self.y+5,self.w+10,self.h-10)
	self.boxY = Box.new(self.x,self.y,self.w,self.h)
	return self
end

function Player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	love.graphics.setColor(0,255,0)
	love.graphics.rectangle("fill", self.boxX.x, self.boxX.y, self.boxX.w, self.boxX.h)

	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", self.boxY.x, self.boxY.y, self.boxY.w, self.boxY.h)


end

function Player:update(dt,level)
	self.vx = 0
	self.vy = 0
	if keyBoardInput["d"] then
		self.vx = self.speed
	end

	if keyBoardInput["q"] then
		self.vx = -self.speed
	end

	if keyBoardInput["z"] then
		self.vy = -self.speed
	end

	if keyBoardInput["s"] then
		self.vy = self.speed
	end

	self.x = self.x + self.vx*dt
	self.y = self.y + self.vy*dt

	self.y = self.y + gravity*dt
	self.boxX.x = self.x-5
	self.boxX.y = self.y+5
	self.boxY.x = self.x
	self.boxY.y = self.y


	for i=1,#level.cases do
		for j=1,#level.cases do
			local case = level.cases[i][j]
			if self.boxY:AABB(case.box) then
				if case.t == 1 then
					local y = self.boxY.h-case.box.y+self.boxY.y
					print(y)
					self.y = (self.y - y*0.7)
				end
			end
		end
	end
	self.boxX.x = self.x-5
	self.boxX.y = self.y+5
	self.boxY.x = self.x
	self.boxY.y = self.y

end

return Player
