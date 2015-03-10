local Hud = {
	lifeHud = nil,
	score = nil,
	time = nil,
	inventory = nil,
	inventoryPanel = nil,
	openInventory = false,
	hudAmmo = nil
}

Hud.__index = Hud
LifeHud = require 'lifeHud'
ScoreHud = require 'scoreHud'
TimeHud = require 'timeHud'
InventoryHud = require 'inventoryHud'
InventoryPanel = require 'inventoryPanel'
HudAmmo = require 'hudAmmo'

function Hud.new(level)
	local self = setmetatable({},Hud)
	self.lifeHud = LifeHud.new(10,10,level.player.maxLife)
	self.score = ScoreHud.new(width/2,10)
	self.time = TimeHud.new(width - 100,10)
	self.inventory = InventoryHud.new(width/2-100,height-50)
	self.inventoryPanel = InventoryPanel.new(width/2,10)
	self.hudAmmo = HudAmmo.new(width/2-100,height-80)

	return self
end

function Hud:draw()
	self.lifeHud:draw()
	self.score:draw()
	self.time:draw()
	self.inventory:draw()
	self.hudAmmo:draw()

	if self.openInventory == true then
		self.inventoryPanel:draw()
	end
end

function Hud:update(dt,level)
	self.lifeHud:update(level.player.life)
	self.score:update(0)
	self.time:update(dt)
	self.hudAmmo:update(level.player.weapon.ammo)
	self.inventory:update(dt,level.player.inventory)
	self.inventoryPanel:update(dt,level.player.inventory)
	if keyBoardInputRelease["i"] then
		if self.openInventory == true then
			self.openInventory = false
			keyBoardInputRelease["i"] = false
		else self.openInventory = true

			keyBoardInputRelease["i"] = false
		end
	end
end

return Hud
