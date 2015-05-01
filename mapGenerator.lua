local MapGenerator = {
	width = 400,
	height = 100,
	numberCenters = 5,
	radius = 10,
	centers = {}
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
		table.insert(self.centers,Point.new(math.random()%self.width,math.random()%self.height,1,self.radius))
	end
end

return MapGenerator
