local MissileShape = {
	w = 0,
	h = 0
}

MissileShape.__index = MissileShape


function MissileShape.new(w,h)
	local self =setmetatable({},MissileShape)

	self.w = w
	self.h = h
	return self
end

function MissileShape:draw(x,y)
	love.graphics.setColor(black)
	love.graphics.rectangle("fill",x,y,self.w,self.h)
end


return MissileShape
