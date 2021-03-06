camera = {}
camera.layers = {}
camera.layer = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.index = 0
camera.ambient = {}
camera.light = {}

function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:update()

	for _,v in ipairs(self.layer) do

		if v.object.dead == true then
			table.remove(self.layer,_)
		end
	end
end

function camera:addAmbient(object)
	table.insert(self.ambient, { object = object})
end

function camera:addLight(object)
	table.insert(self.ambient, { object = object})
end
function camera:newLayer(scale, func)
	table.insert(self.layers, { draw = func, scale = scale })
	table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end

function camera:addLayer(index, object)
	table.insert(self.layer, { object = object, index = index })
end

function camera:simpleDraw()

	local bx, by = self.x, self.y
	for _,v in ipairs(self.layer) do

		if v.index == 1 then

			if v.object.dead == true then
				table.remove(self.layer,_)
			else
				self.x,self.y = bx,by
				camera:set()
				v.object:draw()
				camera:unset()
			end

		end
	end

	for _,v in ipairs(self.ambient) do
		v.object:draw()
	end

	for _,v in ipairs(self.light) do

		self.x,self.y = bx,by
		camera:set()
		v.object:draw()
		camera:unset()
	end
end

function camera:draw()
	local bx, by = self.x, self.y

	for _, v in ipairs(self.layers) do
		self.x = bx * v.scale
		self.y = by * v.scale
		camera:set()
		v.draw()
		camera:unset()
	end
end



function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end


