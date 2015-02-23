local Inventory = {
	object = {},
	index = 0
}

Inventory.__index = Inventory

function Inventory.new()
	local self = setmetatable({},Inventory)
	return self

end

function Inventory:addInventory(o)
	table.insert(self.object,o)
end
