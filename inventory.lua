local Inventory = {
	object = {},
	index = 0,
	size = 3
}

Inventory.__index = Inventory

function Inventory.new()
	local self = setmetatable({},Inventory)
	return self
end

function Inventory:addInventory(o)
	if #self.object < self.size then
		table.insert(self.object,o)
	end
end

function Inventory:setSize(size)
	self.size = size
end

return Inventory
