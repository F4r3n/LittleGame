local MapGenerator = {
	width = 400,
	height = 100,
	numberCenters = 5,
	centers = {},
	tab = {},
	pWidth,
	pHeight,
}

MapGenerator.__index = MapGenerator
Point = require 'point'

function MapGenerator.new(width,height,centers,w,h)
	local self = setmetatable(MapGenerator,{})
	self.numberCenters = centers
	self.width = width
	self.height = height
	self.pWidth = w
	self.pHeight = h
	math.randomseed(os.time())
	return self
end

function MapGenerator:createCenters()
	for i=1,self.numberCenters/5 do
		local p = Point.new(math.random(self.width),math.random(0,self.height/5),1,self.pWidth,self.pHeight)
		self.tab[p.box.y*self.width + p.box.x] = p.t
		table.insert(self.centers,p)
	end


	for i=1,self.numberCenters do
		local p = Point.new(math.random(self.width),math.random(self.height/5,3*self.height/5),1,self.pWidth,self.pHeight)
		self.tab[p.box.y*self.width + p.box.x] = p.t
		table.insert(self.centers,p)
	end

	for i=1,self.numberCenters*3 do
		local p = Point.new(math.random(self.width),math.random(3*self.height/5,self.height),1,self.pWidth,self.pHeight)
		self.tab[p.box.y*self.width + p.box.x] = p.t
		table.insert(self.centers,p)
	end
end

function MapGenerator:initMap()
	local j=1

	for i=1,self.width*self.height do
		self.tab[i] = 0
	end


	self:createCenters()

	for i=1,self.width*self.height do
		if i%self.width==0 then
			j=j+1
		end
		local val = self:findMinCenter(i%self.width,j)
		if val~=0 and self:valTab(i)~=1 then
			self:setValTab(i,self.centers[val].t)
		end
	end
end

function MapGenerator:getLevel2D()
	local map = {}
	for i=1,self.height do
		map[i] = {}
		for j=1,self.width do
			map[i][j] = self.tab[(i-1)*self.width + j]
		end
	end
	return map
end

function MapGenerator:display2D(map)

	for i=1,self.height do
		for j=1,self.width do
			io.write(map[i][j])
		end
		io.write("\n")
	end

end

function MapGenerator:valTab(i)
	return self.tab[i]
end

function MapGenerator:setValTab(i, val)
	self.tab[i] = val
end

function MapGenerator:validRadius(v,x,y)
	return v.box:pointInside(x,y) 

end
function MapGenerator:findMinCenter(x,y)
	local min = 1000
	local pos = 0
	for _,v in pairs(self.centers) do
		if self:validRadius(v,x,y) then
			pos = _
		end
	end
	return pos
end

function MapGenerator:displayMap()
	local j=1
	for i=1,#self.tab do
		io.write(self.tab[i])
		--	print(i)
		if i==self.width*j then
			j=j+1
			io.write("\n")
		end
	end
end

return MapGenerator
