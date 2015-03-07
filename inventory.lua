local Inventory = {
	object = {},
	nbObject = {},
	index = 0,
	size = 3
}

Inventory.__index = Inventory

function Inventory.new()
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

function Inventory:setSize(size)
	self.size = size
end

return Inventory
