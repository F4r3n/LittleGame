local InventoryHud ={
	number = 3,
	w = 300,
	h= 30,
	x = nil,
	y = nil,
	object = {}
	
}

InventoryHud.__index = InventoryHud

function InventoryHud.new(x,y)
	local self = setmetatable({},InventoryHud)
	self.x = x
	self.y = y
	return self

end

function InventoryHud:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
	local size = 100
	love.graphics.setColor(white)
	for i=0,#self.object-1 do
		love.graphics.draw(self.object[i+1].img,self.object[i+1].quad_img,self.x,self.y,0,1,1,0,0)
		love.graphics.setColor(black)
	end

end

function InventoryHud:update(dt,i)
	self.object = i.object
end

return InventoryHud

