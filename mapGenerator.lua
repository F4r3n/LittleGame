local MapGenerator = {
	width = 400,
	height = 100,
	numberCenters = 5,
	radius = 10,
	centers = {},
	tab = {},
}

MapGenerator.__index = MapGenerator
Point = require 'point'

function MapGenerator.new(width,height,centers,radius)
	local self = setmetatable(MapGenerator,{})
	self.numberCenters = centers
	self.width = width
	self.height = height
	self.radius = radius
	math.randomseed(os.time())
	return self
end

function MapGenerator:createCenters()
	for i=1,self.numberCenters do
		local p = Point.new(math.random(self.width),math.random(self.height),1,self.radius)
		self.tab[p.y*self.width + p.y] = p.t
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
	--	print(val)
		if val~=0 and self:valTab(i)~=1 then
			self:setValTab(i,self.centers[val].t)
			--	print(val)
			--	if math.sqrt((v.x-j)*(v.x-j) + (v.y-i)*(v.y-i)) < 
		end
	end
end

function MapGenerator:valTab(i)
	return self.tab[i]
end

function MapGenerator:setValTab(i, val)
	self.tab[i] = val
end

function MapGenerator:validRadius(v,x,y)
return math.sqrt((v.x-x)*(v.x-x) + (v.y-y)*(v.y-y)) < v.radius 
	
end
function MapGenerator:findMinCenter(x,y)
	local min = 1000
	local pos = 0
	local x,y=x,y
	for _,v in pairs(self.centers) do
		if self:validRadius(v,x,y) and min > v.radius then
			min = v.radius
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
