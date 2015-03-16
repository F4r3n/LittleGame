local InventoryHud ={
	number = 3,
	w = 300,
	h= 30,
	x = nil,
	y = nil,
	object = {},
	nbObject = {},
	t = 0,
	boxes = {}
	
}

Box = require('box')
InventoryHud.__index = InventoryHud

function InventoryHud.new(x,y)
	local self = setmetatable({},InventoryHud)
	self.x = x
	self.y = y

	table.insert(self.boxes,Box.new(self.x,self.y,100,10))
	table.insert(self.boxes,Box.new(self.x+100/width,self.y,100,10))
	table.insert(self.boxes,Box.new(self.x+200/width,self.y,100,10))


	return self

end

function InventoryHud:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("line",self.x*width,self.y*height,self.w,self.h)
	local size = 100
	love.graphics.setColor(white)
	for i=0,#self.object-1 do
		love.graphics.draw(self.object[i+1].img,self.object[i+1].quad_img,self.boxes[i+1].x,self.boxes[i+1].y,0,1,1,0,0)
		love.graphics.setColor(black)
	end

end

function InventoryHud:update(dt,i)
	self.boxes[1].x = self.x*width
	self.boxes[2].x = self.x*width+100
	self.boxes[3].x = self.x*width+200

	self.boxes[1].y = self.y*height
	self.boxes[2].y = self.y*height
	self.boxes[3].y = self.y*height
	self.object = i.object
	self.nbObject = i.nbObject
	if #self.object>self.number then
		self.t = self.number
	else self.t = #self.object
	end
end

--TODO Construire un objet contenant les box, l'objet et son nom

return InventoryHud

