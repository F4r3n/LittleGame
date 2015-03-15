
local MenuOptions = {
	buttons = {},
	parent = nil

}

Button = require('button')

MenuOptions.__index = MenuOptions

function MenuOptions.new(parent)
	local self = setmetatable({},MenuOptions)

	self.parent = parent
	local fullScreenButton = Button.new(width/2-50,300,"FullScreen")
	fullScreenButton.f = function()  if fullScreenButton.isActivated then 
		fullScreenButton.name="Windowed" 
	else fullScreenButton.name="FullScreen"
	end
	love.window.setFullscreen(fullScreenButton.isActivated,"desktop")
end
table.insert(self.buttons,fullScreenButton)
table.insert(self.buttons,Button.new(width/2-50,400,"Back",function() menu = self.parent end))

return self
end

function MenuOptions:draw()
	for _,b in ipairs(self.buttons) do
		b:draw()
	end
end

function MenuOptions:update(dt)
	local mx,my = love.mouse.getPosition()
	for _,b in ipairs(self.buttons) do
		if mouseLeftReleased and b.box:pointInside(mx,my) then
			b:activate()
		end
		b:update(dt)
	end

end

return MenuOptions
