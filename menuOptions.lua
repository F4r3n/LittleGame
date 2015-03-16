
local MenuOptions = {
	buttons = {},
	parent = nil

}

Button = require('button')

MenuOptions.__index = MenuOptions

function MenuOptions.new(parent)
	local self = setmetatable({},MenuOptions)

	self.parent = parent
	local fullScreenButton = Button.new(0.4,0.33,"FullScreen")
	fullScreenButton.f = function()  if fullScreenButton.isActivated then 
		fullScreenButton.name="Windowed" 
	else fullScreenButton.name="FullScreen"
	end
	love.window.setFullscreen(fullScreenButton.isActivated,"desktop")
	if fullScreenButton.isActivated then
		width,height=love.graphics.getDimensions()
	else width= WIDTH
		height = HEIGHT
	end
end
table.insert(self.buttons,fullScreenButton)
table.insert(self.buttons,Button.new(0.4,0.2,"Music",function() menu = self.parent end))
table.insert(self.buttons,Button.new(0.4,0.5,"Back",function() menu = self.parent end))

return self
end

function MenuOptions:draw()
	print(width)
	for _,b in ipairs(self.buttons) do
		b:draw()
	end
end

function MenuOptions:update(dt)
	local mx,my = love.mouse.getPosition()
	for _,b in ipairs(self.buttons) do
		b:update(dt,mx,my)
	end

end

return MenuOptions
