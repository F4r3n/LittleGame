
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
	indexObject = {}

}

InventoryPanel.__index = InventoryPanel

function InventoryPanel.new(x,y)
	local self = setmetatable({},InventoryPanel)
	self.x = x
	self.y = y
	return self

end

function InventoryPanel:draw()
	local size = 50
	love.graphics.setColor(white)

	--	for i=0,#self.object-1 do
	--		love.graphics.draw(self.object[i+1].img,self.object[i+1].quad_img,self.x,self.y,0,1,1,0,0)
	--		love.graphics.setColor(black)
	--	endi
	love.graphics.setColor(grey)
	love.graphics.rectangle("fill",self.x,self.y,size*(self.nbCaseX+1)+25,size*(self.nbCaseY+1)+25)

	local cpt = 1
	for i=0,self.nbCaseY do 
		for j=0,self.nbCaseX do
			if self.indexObject[cpt] ~=nil then
				if self.indexObject[cpt].quad_img ~=nil then
					love.graphics.setColor(white)
					love.graphics.draw(self.indexObject[cpt].img,
					self.indexObject[cpt].quad_img,
					self.x+(size+5+size/2)*j+5,
					self.y+(5+size+size/2)*i+5+size/2,0,0.8,0.8)
				else

					love.graphics.draw(self.indexObject[cpt].img,
					self.x+(size+5+size/2)*j+5,
					self.y+(5+size+size/2)*i+5+size/2,0,0.8,0.8)
				end
				love.graphics.setColor(black)
				love.graphics.print(self.nbObject[self.indexObject[cpt].name],self.x+(size+5+size/2)*j+5+size/2,self.y+(5+size+size/2)*i+5+size/2)

			else

				love.graphics.setColor(black)
				love.graphics.rectangle("fill",self.x+(size+5)*j+5,self.y+(5+size)*i+5,size,size)
			end
			cpt = cpt + 1
		end

	end

end

function InventoryPanel:update(dt,i)
	self.object = i.object
	self.nbObject = i.nbObject

	for _,v in pairs(self.object) do
		self.indexObject[_] = v
	end
end

return InventoryPanel