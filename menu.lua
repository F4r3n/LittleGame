local Menu = {
	buttons = {},
	game = nil

}

Button = require('button')
MenuOptions = require('menuOptions')

Menu.__index = Menu

function Menu.new(game)
	local self = setmetatable({},Menu)
	table.insert(self.buttons,Button.new(0.4,0.1,"Play", function() play = true end))
	table.insert(self.buttons,Button.new(0.4,0.2,"New Game", function() game:reload() play=true end ))
	table.insert(self.buttons,Button.new(0.4,0.3,"Options",function() menu = MenuOptions.new(self) end))
	table.insert(self.buttons,Button.new(0.4,0.4,"Quit",function() love.event.quit() end))
	self.game = game;
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
		b:update(dt,mx,my)
	end

end

return Menu
