local Menu = {
	buttons = {}

}

Button = require('button')

Menu.__index = Menu

function Menu.new()
	local self = setmetatable({},Menu)
	table.insert(self.buttons,Button.new(100,100,"Yop"))
	return self
end

function Menu:draw()
	for _,b in ipairs(self.buttons) do
		b:draw()
	end
end

function Menu:update(dt)

	for _,b in ipairs(self.buttons) do
		b:update(dt)
	end
end

return Menu
