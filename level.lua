local Level = {
	player = nil,
	w = 25,
	h = 25,
	levelNumber = 0,
	score = 0,
	levelBase = nil,
	levelEnemies = nil,
	player = nil,
	cases = {},
	bullets = {},
	bonus = {},
	enemies = {},
	scale = 1,
	time = 0,
	shakeTime = 0,
	isShaking = false,
	intervalTime = 0,
	casesAround = {{},{},{},{},{},{},{},{}},
	constructMode = false
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

	camera:addLayer(1,self.player)

	return self
end

function Level:shake(dt)
	if self.shakeTime < 0.1 then
		self.shakeTime = self.shakeTime + dt
		self.intervalTime = self.intervalTime + dt
		if self.intervalTime <0.02 then
			if camera.rotation == 0.01 then
				camera.rotation =-0.01
			else camera.rotation = 0.01
			end
			self.intervalTime = 0
		end
	else self.isShaking =false
		camera.rotation = 0
		self.shakeTime = 0

		self.intervalTime = 0
	end

end




function Level:update(dt)
	local mx,my = love.mouse.getPosition()
	self.time = self.time +dt
	self.player:update(dt,self)

	p:update(dt)
	local x = -self.player.vx 
	local y = -self.player.vy


	if keyBoardInputRelease["p"] then
		if self.constructMode == false then
			self.constructMode = true
			keyBoardInputRelease["p"] = false
		else 
			self.constructMode =false
			keyBoardInputRelease["p"] = false
		end
	end


	if self.constructMode then
		if (self.casesAround[1][1] ~= math.floor((self.player.boxX.x-self.w)/self.w)) 
			or  self.casesAround[1][2] ~= math.floor((self.player.boxX.y)/self.h) then
			grid_batch:clear()
			grid_batch:bind()
			self.casesAround[1][1]=math.floor((self.player.boxX.x-self.w)/self.w)
			self.casesAround[1][2]=math.floor(self.player.boxX.y/self.h)

			self.casesAround[2][1]=math.floor((self.player.boxX.x-self.w)/self.w)
			self.casesAround[2][2]=math.floor((self.player.boxX.y-self.h)/self.h)

			self.casesAround[3][1]=math.floor((self.player.boxX.x-self.w)/self.w)
			self.casesAround[3][2]=math.floor((self.player.boxX.y+self.h)/self.h)

			self.casesAround[4][1]=math.floor((self.player.boxX.x-self.w)/self.w)
			self.casesAround[4][2]=math.floor((self.player.boxX.y-2*self.h)/self.h)

			self.casesAround[5][1]=math.floor((self.player.boxX.x+3*self.w)/self.w)
			self.casesAround[5][2]=math.floor(self.player.boxX.y/self.h)

			self.casesAround[6][1]=math.floor((self.player.boxX.x+3*self.w)/self.w)
			self.casesAround[6][2]=math.floor((self.player.boxX.y-self.h)/self.h)

			self.casesAround[7][1]=math.floor((self.player.boxX.x+3*self.w)/self.w)
			self.casesAround[7][2]=math.floor((self.player.boxX.y+self.h)/self.h)

			self.casesAround[8][1]=math.floor((self.player.boxX.x+3*self.w)/self.w)
			self.casesAround[8][2]=math.floor((self.player.boxX.y-2*self.h)/self.h)
			for i=1,8 do
				grid_batch:add(self.casesAround[i][1]*self.w,self.casesAround[i][2]*self.h)
			end
			grid_batch:unbind()
		end
	end

	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			local a = self.cases[i][j].box
			local c = self.cases[i][j]


			if self.cases[i][j].t == 1 or c.t == 3 then
				for bullet,v in pairs(self.bullets) do
					if  a:AABB(v.box) and c.dead == false then
						p:start()

						p:setPosition(v.x,v.y)
						self.cases[i][j]:dommaged(v.dmg)
						if self.cases[i][j].dead == true then
							p:stop()
							self.cases[i][j].t = 0
							if math.random(100) < 50 then
								local b = Bonus.new(c.x+a.w/2,c.y+a.h,self.cases[i][j].box.x+a.w/2,self.cases[i][j].box.y+a.h)
								table.insert(self.bonus,b)
								camera:addLayer(1,b)
							end
						end

						v.dead = true

					end
				end
			end
		end
	end


	for bullet,v in ipairs(self.bullets) do
		v:update(dt)
		if math.abs(v.box.x - v.owner.boxX.x)>1000 then
			v.dead = true
			table.remove(self.bullets,bullet)
		end

		if v.box:AABB(self.player.boxY) and v.owner.owner == 1 then
			self.player:dommaged(v.dmg)
		end
	end

	love.mouse.setCursor(cursor_white_cross)
	for enemy,v in ipairs(self.enemies) do
		if v.boxY:pointInside(camera.x+mx,camera.y+my) then
			love.mouse.setCursor(cursor_red_cross)
		end
	end


	for bonus,v in ipairs(self.bonus) do
		v:update(dt)
	end

	for enemy,v in ipairs(self.enemies) do
		v:update(dt,self)
		for bullet,b in ipairs(self.bullets) do
			if b.box:AABB(v.boxX) and v.owner ~= b.owner.owner then
				v:dommaged(b.dmg)
				b.dead = true
				table.remove(self.bullets,bullet)
			end
		end

		if v.boxX:AABB(self.player.boxX) then
			self.isShaking = true
			self.player:dommaged(10)
		end
	end

	if self.player.dead == true then 
		love.event.quit()
	end

	for _,b in pairs(self.bonus) do
		if b.box:AABB(self.player.boxY) and b.dead == false then
			local g = self.player:gainLife(10)

			if g==true then
				table.remove(self.bonus,_)
				b.dead = true
			end
		end
	end

	for _,enemy in ipairs(self.enemies) do
		if enemy.dead then
			table.remove(self.enemies,_)
		end
	end

	if keyBoardInputRelease["kp+"] then

		self.scale = self.scale +0.2 
		camera:setScale(self.scale,self.scale)
		keyBoardInputRelease["kp+"] = false
		self.player.offsetCamerax = 400*self.scale
		self.player.offsetCameray = 400*self.scale

	end

	if keyBoardInputRelease["kp-"] then
		if self.scale>0.4 then
			self.scale = self.scale -0.2
			camera:setScale(self.scale,self.scale)

			self.player.offsetCamerax = 400*self.scale
			self.player.offsetCameray = 400*self.scale
			keyBoardInputRelease["kp-"] = false
		end
	end

	if self.isShaking == true then
		self:shake(dt)
	end

	for _,b in pairs(self.bullets) do
		if b.dead == true then
			table.remove(self.bullets,_)
		end
	end


end

function Level:draw()
	love.graphics.draw(p);
	love.graphics.setColor(black)
	if self.constructMode then
		love.graphics.draw(grid_batch)
	end
end

return Level
