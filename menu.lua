local Menu = {
	buttons = {}

}

Button = require('button')
MenuOptions = require('menuOptions')

Menu.__index = Menu

function Menu.new()
	local self = setmetatable({},Menu)
	table.insert(self.buttons,Button.new(width/2-50,100,"Play", function() play = true end))
	table.insert(self.buttons,Button.new(width/2-50,200,"New Game"))
	table.insert(self.buttons,Button.new(width/2-50,300,"Options",function() menu = MenuOptions.new(self) end))
	table.insert(self.buttons,Button.new(width/2-50,400,"Quit",function() love.event.quit() end))

	return self
end

function Menu:draw()
	for _,b in ipairs(self.buttons) do
		b:draw()
	end
end

function Menu:update(dt)
	local mx,my = love.mouse.getPosition()
	for _,b in ipairs(self.buttons) do
		if mouseLeftReleased and b.box:pointInside(mx,my) then
			b:activate()
		end
		b:update(dt)
	end

end

return Menu
