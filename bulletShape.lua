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
	--print(white)
	love.graphics.setColor(white)
	love.graphics.draw(ball_image,x,y)
end


return BulletShape
