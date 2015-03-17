local Inventory = {
	object = {},
	nbObject = {},
	index = 0,
	size = 3,
	player = nil
}

Inventory.__index = Inventory

function Inventory.new(player)
	local self = setmetatable({},Inventory)
	return self
end

function Inventory:addInventory(o)
	if self.object[o.name] == nil then
		if #self.object < self.size then
			table.insert(self.object,o)
			self.nbObject[o.name] = 1
		end
	else 
		self.nbObject[o.name] = self.nbObject[o.name] + 1

	end
end

function Inventory:rmInventory(o)
	if self.object[o.name] ~= nil then
		if self.nbObject[o.name] >1 then
			self.nbObject[o.name] = self.nbObject[o.name] - 1
		else
			table.remove(self.nbObject,o)
			table.remove(self.object,o)
		end
	end
end

function Inventory:setSize(size)
	self.size = size
end

return Inventory
