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
	jumping = true,
	initX = 400,
	initY = 400,
	coolDown = 0.1,
	time = 0,
	dead = false,
	life = 100,
	immortal = 1,
	timeImmortal =0,
	mortal = true,
	maxLife = 100,
	weapon = nil,
	dirX = 0,
	coolDownWeapon = nil,
	weaponTime = 0,
	inventory = nil,
	positionCamerax = 0,
	positionCameray = 0,
	offsetCamerax = 400,
	offsetCameray = 400,
	owner = 0,
	degree = 0,
	hasMoved = false

	
}

Box = require 'box'
Bullet = require 'bullet'
Shotgun = require 'shotgun'
Inventory = require 'inventory'
require('camera')
Rifle = require 'rifle'

Player.__index = Player;

function Player.new(position) 
	local self = setmetatable({},Player);
	self.x = position[1]
	self.y = position[2]
	self.initX = position[1]
	self.initY = position[2]

	self.boxX = Box.new(self.initX-10,self.initY+10,self.w+20,self.h-20)
	self.boxY = Box.new(self.initX,self.initY,self.w,self.h)

	self.weapon = Rifle.new(self.boxX.x+self.w,self.boxX.y-self.h/2)

	self.coolDownWeapon = self.weapon.coolDown

	self.inventory = Inventory.new(self)

	self.inventory:addInventory(self.weapon)
	self.inventory:addInventory(Shotgun.new(self.boxX.x+self.w,self.boxX.y-self.h/2))

	return self
end

function Player:draw()
	love.graphics.setColor(white)
	love.graphics.rectangle("fill", self.boxY.x-10, self.boxY.y+10, self.w+20, self.h-20)
	love.graphics.rectangle("fill", self.boxY.x, self.boxY.y, self.w, self.h)
	if (self.degree>270 and self.degree <360) or (self.degree > 0 and self.degree<90) then
		self.weapon:draw(0,self.boxX.x,self.boxX.y)
	else
		self.weapon:draw(180,self.boxX.x,self.boxX.y)

	end

end


function math.sign(x)
	if x<0 then
		return -1
	elseif x>0 then
		return 1
	else
		return 0
	end
end


function Player:update(dt,level)
	--print(self.x,self.y)
	self.hasMoved = false
	self.time = self.time+dt
	self.timeImmortal = self.timeImmortal + dt

	if self.timeImmortal > self.immortal then
		self.mortal = true
		self.timeImmortal =0
	end


	if keyBoardInput["d"] then
		if self.jumping == true then
			self.vx = self.speed
		end
		self.vx = self.speed
		self.dirX = 0
	end
	local y= -mouseY + 400
	local x= -mouseX + 400
	self.degree = math.atan2(y,-x)*180/math.pi
	if self.degree<0 then self.degree = -math.abs(self.degree) +360 end

	if self.time > self.coolDownWeapon then
		if mousePressedLeft == true and level.constructMode== false then
			self.weapon:shot(self.degree,self,level,nil,nil)
			self.time = 0
		end

	end

	if keyBoardInput["q"] then
		self.vx = -self.speed
		self.dirX = 180

		if self.jumping == true then
			self.vx = -self.speed
		end
	end



	if keyBoardInput[" "] and self.jumping == false then
		self.hasMoved = true
		self.vy = -self.speed*(2/3)
		self.jumping = true
	end

	local left =math.floor(self.boxX.x/level.w)-5
	local right =math.floor(self.boxX.x/level.w)+5
	local up = math.floor(self.boxX.y/level.h)-5
	local down = math.floor(self.boxX.y/level.h)+5
	if left <=1 then left = 1 end
	if right >#level.cases[1] then right = #level.cases[1] end
	if up <=1 then up=1 end
	if down>#level.cases then down = #level.cases end

	for i=up,down do
		for j=left,right do
			local case = level.cases[i][j]
			local b = Box.copy(case.box)
			b.x = b.x - self.vx
			b.y = b.y - self.vy

			if case.t == 1 or case.t ==-1 or case.t==3 then
				if self.boxY:AABB(b) then
					local bottomSide = math.abs(b.h + b.y - (self.boxY.y + self.boxY.h/2))
					local topSide = math.abs(-b.y + self.boxY.y + self.boxY.h/2)

					if topSide < bottomSide then
						local d =(self.boxY.y+self.boxY.h)-b.y
						self.vy = self.vy-d
						self.jumping = false
						if self.vy < -1 then self.vy = -1 end--A améliorer

					else
						local d = math.abs(b.y + b.h - self.boxY.y + 1)
						self.vy = self.vy + d

						if self.vy >1 then self.vy = 1 end--A améliorer

					end
				end
				if self.boxX:AABB(b) then
					local leftSide = math.abs(b.w + b.x - (self.boxX.x+self.boxX.w/2))
					local rightSide = math.abs(-b.x+self.boxX.x + self.boxX.w/2) 
					if leftSide > rightSide  then
						local c = math.abs((self.boxX.x+self.boxX.w)-(b.x)+1)
						self.vx = self.vx-c

					else
						local c =math.abs(b.x+b.w-self.boxX.x+1)
						self.vx = self.vx+c
					end

				end


			end
		end
	end
	local v = self.vx*0.7*(1-dt)
	local g = self.vy + gravity*dt


	if math.abs(self.vx-v) >2 or self.jumping then
		self.hasMoved = true 
	end
	self.vx = v
	self.vy = g

	camera:setPosition(self.boxX.x-self.offsetCamerax,self.boxX.y-self.offsetCameray)
	self:moveUpdate()


end

function Player:dommaged(d)
	if self.mortal == true and self.dead == false then
		self.life = self.life -d
		self.mortal = false
	end
	if self.life <=0 then 
		self.dead = true
	end
end

function Player:gainAmmo(l)
	return  self.weapon:reload(l)

end

function Player:fullAmmo() 
	return self.weapon.ammoMax == self.weapon.ammo

end

function Player:gainLife(l)
	if self.life < self.maxLife then
		self.life = self.life +l
		if self.life > self.maxLife then
			self.life = self.maxLife
		end
		return true
	else return false
	end
	return true
end

function Player:moveUpdate()

	self.positionCamerax = self.boxX.x
	self.positionCameray = self.boxX.y
	self.boxX.x = self.boxX.x + self.vx
	self.boxX.y = self.boxX.y + self.vy
	self.boxY.x = self.boxY.x + self.vx
	self.boxY.y = self.boxY.y + self.vy
end

function Player:maxHealed()
	return self.life == self.maxLife
end

return Player
