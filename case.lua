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

return Case
