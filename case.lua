local Case = {
	t = 0,
	box = nil
}

Case.__index = Case
Box = require 'box'

function Case.new(x,y,w,h,t)
	local self = setmetatable({},Case)
	self.box = Box.new(x,y,w,h)
	self.t = t
	return self
end

return Case
