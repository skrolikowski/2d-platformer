-- Move Component
--

local Base = require 'src.entities.components.component'
local Move = Base:extend()

-- New
--
function Move:new()
	self._axis   = Vec2()
	self._facing = 1
end

-- Update
--
function Move:update(dt)
	if self._axis.x ~= 0 then
		self._facing = self._axis.x
	end
end

---- ---- ---- ----

-- Event: onRequestAxis
--
function Move:onRequestAxis(value)
	self:axis(value)
end

-- Event: onRequestUpdate
--
function Move:onRequestUpdate(dt)
	--
	-- x-axis
	if self._axis.x == 0 then
		self.host:vx(0)
	else
		if self.host:onGround() then
			self.host:vx(self._facing * self.host._speed)
		else
			self.host:vx(self._facing * self.host._speed * 0.85)
		end
	end

	--
	-- y-axis
	-- TODO:
end

---- ---- ---- ----

-- Get/set facing direction
--
function Move:facing(value)
	if value == nil then
		return self._facing
	end

	self._facing = value
end

-- Get/set axis
--
function Move:axis(value)
	if value == nil then
		return self._axis
	end

	self._axis = Vec2(
		value.x or self._axis.x,
		value.y or self._axis.y
	)
end

-- Get/set x-axis
--
function Move:ax(value)
	if value == nil then
		return self._axis.x
	end

	self._axis.x = value
end

-- Get/set y-axis
--
function Move:ay(value)
	if value == nil then
		return self._axis.y
	end

	self._axis.y = value
end

return Move