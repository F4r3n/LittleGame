Sounds = {}


Sound = require('sound')

function Sounds:addSound(name, volume, stream)
	Sounds[name] = Sound.new(name,volume,stream)
end

function Sounds:play(name)
	Sounds[name]:play()
end
