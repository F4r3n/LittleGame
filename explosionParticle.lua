local ExplosionParticle = {
	dead = false,
	particle = nil
	
}

ExplosionParticle.__index = ExplosionParticle

function ExplosionParticle.new()
	local self = setmetatable({}, ExplosionParticle)
	self.particle = ExplosionParticle.create()
	return self
end

function ExplosionParticle.create()
	

	img = love.graphics.newImage('assets/blood.png');
	local particleExplosion = love.graphics.newParticleSystem(img, 100);
	particleExplosion:setParticleLifetime(0.1,5); -- Particles live at least 2s and at most 5s.
	particleExplosion:setSizeVariation(1);
	particleExplosion:setEmissionRate(1000);
	particleExplosion:setEmitterLifetime(1)
	particleExplosion:setLinearAcceleration(-100, -100, 100, 100); -- Random movement in all directions.
	particleExplosion:setColors(255, 255, 255, 255, 255, 255, 255, 0); -- Fade to black.
	particleExplosion:stop()
	return particleExplosion
end

function ExplosionParticle:update(dt)
	self.particle:update(dt)
end

function ExplosionParticle:launch(x,y)
	self.particle:start()
	self.particle:setPosition(x+5,y+5)
end

function ExplosionParticle:draw()
	love.graphics.draw(self.particle)
	if not self.particle:isActive() then
		self.dead = true
	end
end

return ExplosionParticle
