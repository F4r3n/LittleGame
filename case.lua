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
	self.x = x
	self.y = y
	return self
end

function Case:dommaged(d)
	self.life = self.life - d
	if self.life <= 0 then
		self.dead = true
	end
end

function Case:draw()
    love.graphics.setColor(255, 255, 255)
			if self.t == 1 then
				love.graphics.draw(grass_image,grass_quad,self.x,self.y-5,0,1,1,0,0,0,0)
			end


			if self.t == 2 then
				love.graphics.setColor(0,255,0,255)
				love.graphics.rectangle("fill",
				self.x,
				self.y, 
				self.box.w, 
				self.box.h)
			end


			if self.t == 3 then
				love.graphics.draw(earth_image,earth_quad,self.x,self.y,0,1,1,0,0,0,0)
			end
			if self.t == -1 then
				love.graphics.draw(rock_image,rock_quad,self.x,self.y,0,1,1,0,0,0,0)

			end
end

return Case
