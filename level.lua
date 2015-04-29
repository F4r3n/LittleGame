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
	constructMode = false,
	sprites = nil,
	refresh = true,
	bonusAmmo = {},
	bonusHeal = {},
	items = {},
	night
}

Level.__index = Level
LevelBase = require 'levelBase'
Case = require 'case'
Bullet = require 'bullet'
Bonus = require 'bonus'
Enemy = require 'enemy'
SpritesBatch = require 'spritesBatch'
LevelEnemies = require 'levelEnemies'
BonusHeal = require 'bonusHeal'
BonusAmmo = require 'bonusAmmo'
Item = require 'item'
Night = require 'night'


function Level.new(n,player)
	local self = setmetatable({},Level)
	self.levelBase = LevelBase[2*n+1]
	self.levelEnemies = LevelEnemies[2*n+1]
	self.player = player
	self.night = Night.new({100,100,100,100})

	earth_batch:clear()
	grass_batch:clear()
	rock_batch:clear()

	for i=1,#self.levelBase do
		self.cases[i] = {}
		for j=1,#self.levelBase[i] do
			self.cases[i][j] = Case.new((j-1)*self.w,
			(i-1)*self.h,
			self.w,
			self.h,
			self.levelBase[i][j])

			if self.levelBase[i][j]==3 then
				earth_batch:add(earth_quad,self.cases[i][j].x,self.cases[i][j].y)
			elseif self.levelBase[i][j]==-1 then
				rock_batch:add(grass_quad,self.cases[i][j].x,self.cases[i][j].y)
			elseif self.levelBase[i][j]==1 then
				grass_batch:add(grass_quad,self.cases[i][j].x,self.cases[i][j].y)

			end
		end
	end


	self.sprites =SpritesBatch.new(earth_batch,grass_batch,rock_batch)
	camera:addLayer(1,self.sprites)
	self:loadEnemies()
	camera:addLayer(1,self.player)
	camera:addAmbient(self.night)

	return self
end

function Level:loadEnemies()

	for i=1,#self.levelEnemies do
		for j=1,#self.levelEnemies[i] do
			if self.levelEnemies[i][j] >=10 then
				local e = Enemy.new((j-1)*self.w,(i-1)*self.h)
				table.insert(self.enemies,e)
				camera:addLayer(1,e)
			end
		end 
	end
end

function Level:reload()
	for _,v in ipairs(self.enemies) do v.dead = true end
	self.score =0
	self.time = 0
	camera:update()
	self:loadEnemies()

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

function Level:chooseCursor()

	local isSpecial = false
	local mx,my = love.mouse.getPosition()
	local x = camera.x+mx*self.scale
	local y = camera.y+my*self.scale

	if self.constructMode then

		isSpecial = true
		love.mouse.setCursor(cursor_build_cross_black)
		for i=1,8 do
			if Box.pointInside2(x,
				y,
				self.casesAround[i][1]*self.w,
				self.casesAround[i][2]*self.h,
				self.w,
				self.h) then
				if mousePressedLeft and self.cases[self.casesAround[i][2]+1][self.casesAround[i][1]+1].t ==0 then
					self.cases[self.casesAround[i][2]+1][self.casesAround[i][1]+1]:init(1)
					self.refresh = true
					
				end
			end
		end
	end

	if self.player.boxY.y/self.h > #self.levelBase+10 then
		love.event.quit()
	end


	for enemy,v in ipairs(self.enemies) do
		if v.boxY:pointInside(camera.x+mx,camera.y+my) then
			isSpecial = true
			love.mouse.setCursor(cursor_red_cross)
		end
	end
	if isSpecial ==false then 
		love.mouse.setCursor(cursor_white_cross)
	end

end




function Level:update(dt)
	self.night:update(dt)
	self.time = self.time +dt
	self.player:update(dt,self)

	p:update(dt)
	local x = -self.player.vx 
	local y = -self.player.vy

	local distanceEnemy=0
	for _,v in ipairs(self.enemies) do
		local d = math.abs(self.player.boxX.x-v.boxX.x)
		if  distanceEnemy<d then
			distanceEnemy = d
		end
	end

	if (distanceEnemy < 500 and distanceEnemy~=0) and self.constructMode == true then self.constructMode=false end

	if keyBoardInputRelease["c"] then
		if (distanceEnemy > 500 or distanceEnemy==0)  and math.floor((self.player.boxX.y+(1)*self.h)/self.h) >2 then
			if self.constructMode == false then
				self.constructMode = true
			else 
				self.constructMode =false
			end
		end
		keyBoardInputRelease["c"] = false
	end

	if self.constructMode then
		if math.floor((self.player.boxX.y+(-3)*self.h)/self.h) <2
			or math.floor((self.player.boxX.x+3*self.w)/self.w) > #self.cases[1] then
			self.constructMode = false
		end
	end


	if self.constructMode then
		if  self.casesAround[1][1] ~= math.floor((self.player.boxX.x-self.w)/self.w) then
			if (self.casesAround[1][1] ~= math.floor((self.player.boxX.x-self.w)/self.w)) 
				or  self.casesAround[1][2] ~= math.floor((self.player.boxX.y)/self.h) then
				grid_batch:clear()

				if math.floor((self.player.boxX.y+(1)*self.h)/self.h) >0 then
					for i=1,4 do
						self.casesAround[i][1]=math.floor((self.player.boxX.x-self.w)/self.w)
						self.casesAround[i][2]=math.floor((self.player.boxX.y+(-i+2)*self.h)/self.h)
					end

					for i=1,4 do
						self.casesAround[i+4][1]=math.floor((self.player.boxX.x+3*self.w)/self.w)
						self.casesAround[i+4][2]=math.floor((self.player.boxX.y+(-i+2)*self.h)/self.h)
					end
				end


				for i=1,8 do
					grid_batch:add(self.casesAround[i][1]*self.w,self.casesAround[i][2]*self.h)
				end
			end
		end
	end




	for _,v in ipairs(self.bullets) do

		local lb = math.floor(v.box.x/self.w)-1
		local rb = math.floor(v.box.x/self.w)+1
		local ub = math.floor(v.box.y/self.h)-1
		local db = math.floor(v.box.y/self.h)+1
		if lb <=1 then lb = 1 end
		if rb >#self.cases[1] then rb = #self.cases[1] end

		if ub <=1 then ub=1 end
		if db>#self.cases then db = #self.cases end

		for i=ub,db do
			for j=lb,rb do
				local a = self.cases[i][j].box
				local c = self.cases[i][j]
				if c.t == 1 or c.t == 3 then
					if  a:AABB(v.box) and c.dead == false then
						p:start()

						p:setPosition(v.x,v.y)
						self.cases[i][j]:dommaged(v.dmg)
						if self.cases[i][j].dead == true then
							p:stop()
							self.refresh = true
							self.cases[i][j].t = 0
							if math.random(100) < 25 then
								local b = BonusHeal.new(c.x+a.w/2,c.y+a.h)
								table.insert(self.bonusHeal,b)
								camera:addLayer(1,b)
							elseif math.random(100)>75 then

								local b = BonusAmmo.new(c.x+a.w/2,c.y+a.h)
								table.insert(self.bonusAmmo,b)
								camera:addLayer(1,b)

							end
						end

						v.dead = true

					end

				end
			end
		end

	end



	if self.refresh then
		self:refreshMap()
		self.refresh = false
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


	for bonus,v in ipairs(self.bonusHeal) do
		v:update(dt)
	end

	for bonus,v in ipairs(self.bonusAmmo) do
		v:update(dt)
	end

	for enemy,v in ipairs(self.enemies) do
		v:update(dt,self)
		for bullet,b in ipairs(self.bullets) do
			if b.box:AABB(v.boxY) and v.owner ~= b.owner.owner then
				v:dommaged(b.dmg)
				b.dead = true
				table.remove(self.bullets,bullet)
				if v.dead then
					local i = Item.new(v.boxX.x,v.boxX.y)
					table.insert(self.items,i)
					camera:addLayer(1,i)
				end

			end
		end

		if v.boxX:AABB(self.player.boxY) then
			self.isShaking = true
			self.player:dommaged(10)
		end
	end

	if self.player.dead == true then 
		love.event.quit()
	end

	if self.player:fullAmmo() == false then
		for _,b in pairs(self.bonusAmmo) do
			if b.box:AABB(self.player.boxY) and b.dead == false then
				local g = b:action(self.player)
				if g==true then
					table.remove(self.bonusAmmo,_)
					b.dead = true
				end
			end
		end
	end
	if self.player:maxHealed() == false then
		for _,b in pairs(self.bonusHeal) do
			if b.box:AABB(self.player.boxY) and b.dead == false then
				local g = b:action(self.player)

				if g==true then
					table.remove(self.bonusHeal,_)
					b.dead = true
				end
			end
		end
	end
	for _,enemy in ipairs(self.enemies) do
		if enemy.dead then
			self.score = self.score +enemy.score
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

	for _,item in pairs(self.items) do
		item:update(dt,self)
	end

	self:chooseCursor()

end
function Level:refreshMap()

	self.sprites.earth:clear()
	self.sprites.rock:clear()
	self.sprites.grass:clear()
	for i=1,#self.cases do
		for j=1,#self.cases[i] do
			local a = self.cases[i][j].box
			local c = self.cases[i][j]

			if c.t == 3 then
				self.sprites.earth:add(earth_quad,c.x,c.y)
			elseif c.t==-1 then
				self.sprites.rock:add(rock_quad,c.x,c.y)
			elseif c.t==1 then
				self.sprites.grass:add(grass_quad,c.x,c.y-5)
			end
		end
	end



end

function Level:draw()

	love.graphics.setColor(white)
	love.graphics.draw(p);
	if self.constructMode then
		love.graphics.draw(grid_batch)
	end
end

return Level
