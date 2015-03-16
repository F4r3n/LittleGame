local ScoreHud = {
	x=0,
	y=0,
	score = 0
}

ScoreHud.__index = ScoreHud

function ScoreHud.new(x,y)
	local self  = setmetatable({}, ScoreHud)
	self.x = x
	self.y = y
	return self
end

function ScoreHud:draw()
	love.graphics.setColor(white)
	love.graphics.print("Score ".. self.score,self.x*width,self.y*height)
end

function ScoreHud:update(l)
	self.score = l.score
end

return ScoreHud

