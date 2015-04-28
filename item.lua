
local Item = {
	x = 0,
	y = 0,
	taken = false,
	life = 10,
	w = 5,
	h = 5,
	box,
	dead = false,
	img = nil,
	vy = 0
}

Item.__index = Item
Box = require 'box'
Shotgun = require 'shotgun'

function Item.new(x,y)
	local self = setmetatable({},Item)
	self.x = x
	self.y = y
	self.img = bonus_heal_image
	self.box = Box.new(self.x,self.y,self.w,self.h)
	return self
end

function Item:draw()
	love.graphics.setColor(white)
	love.graphics.rectangle("fill", self.box.x-5,self.box.y-5,self.w,self.h)
end

function Item:action(player,object)
--	local x = player.boxY.x+player.w/2
--	local y = player.boxX.y-player.h/2
	player.inventory:addInventory(object)
end

function Item:update(dt,level)

	local left =math.floor(self.box.x/level.w)-5
	local right =math.floor(self.box.x/level.w)+5
	local up = math.floor(self.box.y/level.h)-5
	local down = math.floor(self.box.y/level.h)+5
	if left <=1 then left = 1 end
	if right >#level.cases[1] then right = #level.cases[1] end
	if up <=1 then up=1 end
	if down>#level.cases then down = #level.cases end

	for i=up,down do
		for j=left,right do
			local case = level.cases[i][j]
			local b = Box.copy(case.box)
			b.y = b.y - self.vy

			if case.t == 1 or case.t ==-1 or case.t==3 then
				if self.box:AABB(b) then
					local bottomSide = math.abs(b.h + b.y - (self.box.y + self.box.h/2))
					local topSide = math.abs(-b.y + self.box.y + self.box.h/2)
					if topSide < bottomSide then
						local d =(self.box.y+self.box.h)-b.y
						self.vy = self.vy-d
					else
						local d = math.abs(b.y + b.h - self.box.y + 1)
						self.vy = self.vy + d

					end
				end


			end
		end
	end

	self.vy = self.vy + gravity*dt
	self.box.y = self.box.y + self.vy

end

return Item
