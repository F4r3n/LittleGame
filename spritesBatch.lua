local SpritesBatch ={
	earth = nil,
	grass = nil,
	rock = nil

}
SpritesBatch.__index = SpritesBatch

function SpritesBatch.new(e,grass,rock)
	local self  = setmetatable({},SpritesBatch)
	self.earth = e
	self.grass = grass
	self.rock = rock
	return self
end

function SpritesBatch:draw()
	love.graphics.setColor(white)
	love.graphics.draw(self.earth)
	love.graphics.draw(self.rock)
	love.graphics.draw(self.grass)

	love.graphics.setColor(white)

end


return SpritesBatch



