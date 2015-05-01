local Point = {
	x,
	y,
	t,
	radius
}

Point.__index = Point

function Point.new(x,y,t,radius)
	local self = setmetatable({},Point)
	self.x,self.y,self.t,self.radius = x,y,t,radius
	return self
end

return Point
