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
		for j=1,#self.levelBase[i] do
			self.cases[i][j] = Case.new((j-1)*self.w,
			(i-1)*self.h,
			self.w,
			self.h,
			self.levelBase[i][j])
		end
	end
	return self
end

function Level:reload()
	for i=1,#self.levelBase do
		self.cases[i] = {}
		for j=1,#self.levelBase[i] do
			self.cases[i][j] = Case.new((j-1)*self.w,
			(i-1)*self.h,
			self.w,
			self.h,
			self.levelBase[i][j])
		end
	end

end


function Level:update(dt)
	self.player:update(dt,self)
	local x = -self.player.vx 
	local y = -self.player.vy


	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			local a = self.cases[i][j].box
			self.cases[i][j].box.x = a.x+x
			self.cases[i][j].box.y = a.y+y

			if self.cases[i][j].t == 1 then
				for bullet,v in ipairs(self.bullets) do
					if  v.box:AABB(self.cases[i][j].box) then
						self.cases[i][j]:dommaged(v.dmg)
						if self.cases[i][j].dead == true then
							self.cases[i][j].t = 0
						end
						table.remove(self.bullets,bullet)
					end
				end
			end
		end
	end


	for bullet,v in ipairs(self.bullets) do
		v:update(dt,x,y)
		if v.box.x > width*2 or v.box.x < -200 or v.box.y < 0 then
			table.remove(self.bullets,bullet)
		end

	end



end

function Level:draw()

	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			self.cases[i][j]:draw()
		end
	end

	for bullet,v in ipairs(self.bullets) do
		v:draw()
	end
	self.player:draw()
end

return Level
