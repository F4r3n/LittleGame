
local BulletShape = {
	w = 0,
	h = 0
}

BulletShape.__index = BulletShape


function BulletShape.new(w,h)
	local self =setmetatable({},BulletShape)

	self.w = w
	self.h = h
	return self
end

function BulletShape:draw(x,y)
	love.graphics.setColor(black)
	love.graphics.rectangle("fill",x,y,self.w,self.h)
end


return BulletShape