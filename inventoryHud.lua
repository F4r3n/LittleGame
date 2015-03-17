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
InventoryBox = require('inventoryBox')
InventoryHud.__index = InventoryHud

function InventoryHud.new(x,y,player)
	local self = setmetatable({},InventoryHud)
	self.x = x
	self.y = y
	self.player = player

	table.insert(self.boxes,InventoryBox.new(self.x,self.y,100,30))
	table.insert(self.boxes,InventoryBox.new(self.x+100/width,self.y,100,30))
	table.insert(self.boxes,InventoryBox.new(self.x+200/width,self.y,100,30))


	return self

end

function InventoryHud:draw()
	love.graphics.setColor(black)
	love.graphics.rectangle("line",self.x*width,self.y*height,self.w,self.h)
	local size = 100
	love.graphics.setColor(white)
	for _,b in ipairs(self.boxes) do
		b:draw()
	end

end

function InventoryHud:update(dt,i)

	for _,b in ipairs(self.boxes) do
		b:update(dt)
		if b.object ~= nil then
			if b.isSelected then
				b.object:activate(self.player)
				b.isSelected = false
			end
		end
	end

	for _,o in pairs(i.object) do
		self.boxes[_].object = o
		self.boxes[_].nb = i.nbObject[o.name]
	end
	if #self.object>self.number then
		self.t = self.number
	else self.t = #self.object
	end


end


return InventoryHud

