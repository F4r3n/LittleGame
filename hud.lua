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
	self.lifeHud = LifeHud.new(0.05,0.05,level.player.maxLife)
	self.score = ScoreHud.new(0.5,0.05)
	self.time = TimeHud.new(0.9,0.05)
	self.inventory = InventoryHud.new(0.4,0.95,level.player)
	self.inventoryPanel = InventoryPanel.new(0.5,0.05,level.player)
	self.hudAmmo = HudAmmo.new(0.4,0.90)

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
	self.score:update(level)
	self.time:update(level.time)
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
