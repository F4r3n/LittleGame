local InventoryBox = {
	box = nil,
	object=nil,
	nb = nil,
	x,
	y,
	inside = false,
	isSelected = false
}

InventoryBox.__index = InventoryBox

Box = require('box')

function InventoryBox.new(x,y,w,h,object)
	local self = setmetatable({},InventoryBox)
	self.x = x
	self.y = y
	self.box = Box.new(x*width,y*height,w,h)
	self.object = object

	return self
end

function InventoryBox:update(dt)

	if self.box:pointInside(mx,my) then
		self.inside = true
		if mouseLeftReleased then
			self.isSelected = true
		end
	else self.inside = false
	
	end

	self.box.x = self.x*width
	self.box.y = self.y*height
end

function InventoryBox:draw()

	if self.inside then
		love.graphics.setColor({255,255,255,100})
		love.graphics.rectangle("fill",self.box.x,self.box.y,self.box.w,self.box.h)
	end
	love.graphics.setColor(white)

	if self.object ~= nil then
		love.graphics.draw(self.object.img,self.object.quad_img,self.box.x,self.box.y+self.box.h/3,0,1,1,0,0)
	end

end


return InventoryBox
