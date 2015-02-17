local Box = {
	x= nil,
	y = nil,
	w = nil,
	h = nil
}

Box.__index = Box

function Box.new(x,y,w,h)
	local self = setmetatable({},Box)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	return self
end

function Box.copy(box)
	local self = setmetatable({},Box)
	self.x = box.x
	self.y = box.y
	self.w = box.w
	self.h = box.h
	return self	
end

function Box:AABB(box)
	return self.x < box.x+box.w and
	box.x < self.x+self.w and
	self.y < box.y+box.h and
	box.y < self.y+self.h
end

return Box
