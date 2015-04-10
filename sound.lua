local Sound ={
	name = nil,
	volume = 1.0,
	audio = nil,
	stream = ""
}

Sound.__index = Sound

function Sound.new(name, volume, stream) 
	local self = setmetatable({}, Sound)
	self.name = name
	self.volume = volume
	self.stream = stream
	self.audio = love.audio.newSource(name,stream)
	self.audio.setVolume(self.volume)
	return self
end

function Sound:play()
	self.audio:play()
end

return Sound
