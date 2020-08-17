-- Velocity Component
--

local Base     = require 'modern'
local Velocity = Base:extend()

-- New
--
function Velocity:new(host, data)
	--
	self.host = host

	-- properties
	self._spd    = data.spd or 150
	self._spdMax = self._spd * 2
	self._vel    = Vec2()
	self._force  = Vec2()
end

-- Get/set `vel` value.
--
function Velocity:vel(value)
	if value == nil then
		return self._vel
	end

	self._vel = Vec2(
		value.x or self._vel.x,
		value.y or self._vel.y
	)
end

-- Get/set x-velocity
--
function Velocity:vx(value)
	if value == nil then
		return self._vel.x
	end

	self._vel.x = value
end

-- Get/set y-velocity
--
function Velocity:vy(value)
	if value == nil then
		return self._vel.y
	end

	self._vel.y = value
end

-- Get/set force
--
function Velocity:force(value)
	if value == nil then
		return self._force
	end

	self._force = Vec2(
		value.x or self._force.x,
		value.y or self._force.y
	)
end

-- Get/set x-force
--
function Velocity:fx(value)
	if value == nil then
		return self._force.x
	end

	self._force.x = value
end

-- Get/set y-force
--
function Velocity:fy(value)
	if value == nil then
		return self._force.y
	end

	self._force.y = value
end

-- Get/set `spd` value.
--
function Velocity:spd(value)
	if value == nil then
		return self._spd
	end

	self._spd = value
end

-- Get/set `spdMax` value.
--
function Velocity:spdMax(value)
	if value == nil then
		return self._spdMax
	end

	self._spdMax = value
end

return Velocity