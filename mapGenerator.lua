local MapGenerator = {
	width = 400,
	height = 100,
	numberCenters = 5,
	radius = 10,
	centers = {},
	tab = {}
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

function MapGenerator:initMap()
	for i=1,self.height do
		self.tab[i] = {}
		for j=1,self.width do
			self.tab[i][j] = 0
			for _,v in ipairs(self.centers) do
	--			if math.sqrt((v.x-j)*(v.x-j) + (v.y-i)*(v.y-i)) <
			end
		end
	end


end

return MapGenerator
