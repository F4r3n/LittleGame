local Level = {
	player = nil,
	w = 100,
	h = 100,
	levelNumber = 0,
	score = 0,
	levelBase = nil,
	player = nil,
	cases = {},
	bullets = {}
}

Level.__index = Level
LevelBase = require 'levelBase'
Case = require 'case'
Bullet = require 'bullet'

function Level.new(n,player)
	local self = setmetatable({},Level)
	self.levelBase = LevelBase[n]
	self.player = player

	for i=1,#self.levelBase do
		self.cases[i] = {}
		for j=1,#self.levelBase do
			self.cases[i][j] = Case.new((j-1)*self.w,(i-1)*self.h,self.w,self.h,self.levelBase[i][j])
		end
	end
	return self
end

function Level:update(dt)
	self.player:update(dt,self)
	for bullet,v in ipairs(self.bullets) do
		v:update(dt)
	end

end

function Level:draw()
	local x = -self.player.x + self.player.initX
	local y = -self.player.y + self.player.initY

	for i=1,#self.cases do
		for j=1,#self.cases do
			if self.cases[i][j].t == 1 then
				love.graphics.setColor(255,0,0)
				love.graphics.rectangle("fill",
										self.cases[i][j].box.x-self.player.x + self.player.initX,
										self.cases[i][j].box.y-self.player.y + self.player.initY, 
										self.cases[i][j].box.w, 
										self.cases[i][j].box.h)

			end

			if self.cases[i][j].t == 0 then
				love.graphics.setColor(0,0,255)
				love.graphics.rectangle("fill",
										self.cases[i][j].box.x-self.player.x + self.player.initX,
										self.cases[i][j].box.y-self.player.y + self.player.initY, 
										self.cases[i][j].box.w, 
										self.cases[i][j].box.h)
			end

			if self.cases[i][j].t == 2 then
				love.graphics.setColor(0,255,0)
				love.graphics.rectangle("fill",
										self.cases[i][j].box.x-self.player.x + self.player.initX,
										self.cases[i][j].box.y-self.player.y + self.player.initY, 
										self.cases[i][j].box.w, 
										self.cases[i][j].box.h)


			end

		end
	end

	for bullet,v in ipairs(self.bullets) do
		v:draw(x,y)
	end
	self.player:draw()
end

return Level
