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
	love.graphics.print("Score ".. self.score,self.x,self.y)
end

function ScoreHud:update(score)
	self.score = self.score + score
end

return ScoreHud

