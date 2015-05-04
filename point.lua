local Point = {
	box,
	t
}

Point.__index = Point
Box = require 'box'

function Point.new(x,y,t,w,h)
	local self = setmetatable({},Point)
	self.box = Box.new(x,y,w,h)
	self.t = t
	return self
end

return Point
