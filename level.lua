local Level = {
	player = nil,
	w = 100,
	h = 100,
	levelNumber = 0,
	score = 0,
	levelBase = nil,
	player = nil,
	cases = {}
}

Level.__index = Level
LevelBase = require 'levelBase'
Case = require 'case'

function Level.new(n,player)
	local self = setmetatable({},Level)
	self.levelBase = LevelBase[n]
	self.player = player

	for i=1,#self.levelBase do
		self.cases[i] = {}
		for j=1,#self.levelBase do
			self.cases[i][j] = Case.new((i-1)*self.w,(j-1)*self.h,self.w,self.h,self.levelBase[j][i])
		end
	end
	return self
end

function Level:update(dt)
	self.player:update(dt,self)

end

function Level:draw()
	for i=1,#self.cases do
		for j=1,#self.cases do
			if self.cases[i][j].t == 1 then
				love.graphics.setColor(255,0,0)
				love.graphics.rectangle("fill",self.cases[i][j].box.x,self.cases[i][j].box.y, self.cases[i][j].box.w, self.cases[i][j].box.h)

			end

			if self.cases[i][j].t == 0 then
				love.graphics.setColor(0,0,255)
				love.graphics.rectangle("fill",self.cases[i][j].box.x,self.cases[i][j].box.y, self.cases[i][j].box.w, self.cases[i][j].box.h)

			end

		end
	end
	self.player:draw()
end

return Level
