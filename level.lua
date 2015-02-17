local Level = {
	player = nil,
	w = 100,
	h = 100,
	levelNumber = 0,
	score = 0,
	levelBase = nil,
	levelEnemies = nil,
	player = nil,
	cases = {},
	bullets = {},
	bonus = {},
	enemies = {}
}

Level.__index = Level
LevelBase = require 'levelBase'
Case = require 'case'
Bullet = require 'bullet'
Bonus = require 'bonus'
Enemy = require 'enemy'
LevelEnemies = require 'levelEnemies'

function Level.new(n,player)
	local self = setmetatable({},Level)
	self.levelBase = LevelBase[2*n+1]
	self.levelEnemies = LevelEnemies[2*n+1]
	self.player = player

	for i=1,#self.levelBase do
		self.cases[i] = {}
		for j=1,#self.levelBase[i] do
			self.cases[i][j] = Case.new((j-1)*self.w,
										(i-1)*self.h,
										self.w,
										self.h,
										self.levelBase[i][j])

			camera:addLayer(1,self.cases[i][j]:draw())
		end
	end

	for i=1,#self.levelEnemies do
		for j=1,#self.levelEnemies[i] do
			if self.levelEnemies[i][j] >=10 then
				table.insert(self.enemies,Enemy.new((j-1)*self.w,(i-1)*self.h))
			end
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

	p:update(dt)
	local x = -self.player.vx 
	local y = -self.player.vy

	local px,py = p:getPosition()
	p:moveTo(px+x,py+y)


	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			local a = self.cases[i][j].box
			self.cases[i][j].box.x = a.x+x
			self.cases[i][j].box.y = a.y+y

			if self.cases[i][j].t == 1 then
				for bullet,v in ipairs(self.bullets) do
					if  v.box:AABB(self.cases[i][j].box) then
						p:moveTo(v.box.x+x,v.box.y+y)
						p:start()
						self.cases[i][j]:dommaged(v.dmg)
						if self.cases[i][j].dead == true then
							p:stop()
							self.cases[i][j].t = 0
							if math.random(100) < 50 then
								table.insert(self.bonus,Bonus.new(a.x+x+a.w/2,a.y+y+a.h-10))
							end
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



	for bonus,v in ipairs(self.bonus) do
		v:update(dt,x,y)
	end

	for enemy,v in ipairs(self.enemies) do
		v:update(dt,self,x,y)
		for bullet,b in ipairs(self.bullets) do
			if b.box:AABB(v.boxX) then
				v:dommaged(b.dmg)	
				if v.dead then
					table.remove(self.enemies,enemy)
				end
				table.remove(self.bullets,bullet)
			end
		end
	end


end

function Level:draw()

	local x = -self.player.vx 
	local y = -self.player.vy

	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			self.cases[i][j]:draw()
		end
	end

	for bullet,v in ipairs(self.bullets) do
		v:draw()
	end


	for bonus,v in ipairs(self.bonus) do
		v:draw()
	end
	for enemy,v in ipairs(self.enemies) do
		v:draw()
	end

	self.player:draw()

    love.graphics.draw(p, 0,0);
end

return Level
