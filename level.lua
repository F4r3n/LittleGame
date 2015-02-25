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

			camera:addLayer(1,self.cases[i][j])
		end
	end

	for i=1,#self.levelEnemies do
		for j=1,#self.levelEnemies[i] do
			if self.levelEnemies[i][j] >=10 then
				local e = Enemy.new((j-1)*self.w,(i-1)*self.h)
				table.insert(self.enemies,e)
				camera:addLayer(1,e)
			end
		end 
	end

	camera:addLayer(0,self.player)

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
								local b = Bonus.new(self.cases[i][j].x+a.w/2,self.cases[i][j].y+a.h-5)
								table.insert(self.bonus,b)
								camera:addLayer(1,b)
							end
						end

						v.dead = true
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
				b.dead = true
				table.remove(self.bullets,bullet)
			end
		end

		if v.boxX:AABB(self.player.boxX) then
			self.player:dommaged(10)
		end
	end

	if self.player.dead == true then 
		love.event.quit()
	end

	for _,b in ipairs(self.bonus) do

		if b.box:AABB(self.player.boxX) then
			local g = self.player:gainLife(10)
			b.dead = true
			if g==true then
				table.remove(self.bonus,_)
			end
		end
	end

	for _,enemy in ipairs(self.enemies) do
		if enemy.dead then
			table.remove(self.enemies,_)
		end
	end


end

function Level:draw()

	local x = -self.player.vx 
	local y = -self.player.vy



	self.player:draw()

--	love.graphics.draw(p);
end

return Level
