-- Gravity Component
-- Does entity obey laws of gravity?
--

local Base    = require 'src.entities.components.component'
local Gravity = Base:extend()

-- New..
--
function Gravity:new(height, dt)
	height = height or Config.world.tileSize * 6
	dt     = dt or 0.4
	--
	self._gravity = 2 * height / dt^2
end

-- Update..
--
function Gravity:update(dt)
	if self.host:onLedge() then
		return
	end

	--
	-- apply gravity
	self.host:fy(self.host:fy() + self._gravity)
end

---- ---- ---- ----

-- Get/set gravity
--
function Gravity:gravity(value)
	if value == nil then
		return self._gravity
	end

	self._gravity = value
end

return Gravity