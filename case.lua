local Case = {
	t = 0,
	box = nil,
	life = 100,
	dead = false
}

Case.__index = Case
Box = require 'box'

function Case.new(x,y,w,h,t)
	local self = setmetatable({},Case)
	self.box = Box.new(x,y,w,h)
	self.t = t
	return self
end

function Case:dommaged(d)
	self.life = self.life - d
	if self.life <= 0 then
		self.dead = true
	end
end

function Case:draw()
			if self.t == 1 then
				love.graphics.setColor(255,0,0,self.life*2)
				love.graphics.rectangle("fill",
				self.box.x,
				self.box.y, 
				self.box.w, 
				self.box.h)
			end

			if self.t == 0 then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("fill",
				self.box.x,
				self.box.y, 
				self.box.w, 
				self.box.h)
			end

			if self.t == 2 then
				love.graphics.setColor(0,255,0,255)
				love.graphics.rectangle("fill",
				self.box.x,
				self.box.y, 
				self.box.w, 
				self.box.h)
			end
			if self.t == -1 then
				love.graphics.setColor(100,100,100,255)
				love.graphics.rectangle("fill",
				self.box.x,
				self.box.y, 
				self.box.w, 
				self.box.h)
			end
end

return Case
