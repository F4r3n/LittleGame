
local InventoryPanel ={
	number = 3,
	w = 300,
	h= 30,
	x = nil,
	y = nil,
	nbCaseX = 3,
	nbCaseY = 3,
	object = {},
	nbObject = {},
	indexObject = {},
	boxes = {},
	player =nil

}

InventoryBox = require('inventoryBox')

InventoryPanel.__index = InventoryPanel

function InventoryPanel.new(x,y,player)
	local self = setmetatable({},InventoryPanel)
	self.x = x
	self.y = y
	self.player = player

	local size = 50
	for i=0,self.nbCaseY do 
		for j=0,self.nbCaseX do
			table.insert(self.boxes,
			InventoryBox.new((x*width+(size+5)*j+5)/width,
							(y*height+(5+size)*i+5)/height,size,size))
		end
	end
	return self

end

function InventoryPanel:draw()
	local size = 50
	love.graphics.setColor(white)
	local x = self.x*width
	local y = self.y*height
	love.graphics.setColor(grey)
	love.graphics.rectangle("fill",x,y,size*(self.nbCaseX+1)+25,size*(self.nbCaseY+1)+25)

	local cpt = 1
	for i=0,self.nbCaseY do 
		for j=0,self.nbCaseX do
			if self.boxes[cpt].nb ~=nil then
				self.boxes[cpt]:draw()
			else
				love.graphics.setColor(black)
				love.graphics.rectangle("fill",x+(size+5)*j+5,y+(5+size)*i+5,size,size)
			end
			cpt = cpt + 1
		end

	end

end

function InventoryPanel:update(dt,i)

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

	for _,v in pairs(self.object) do
		self.indexObject[_] = v
	end
end

return InventoryPanel
