-- Axis Component
--

local Base = require 'modern'
local Axis = Base:extend()

-- New
--
function Axis:new(host, data)
	self.host = host
	
	--
	-- properties
	self._axis   = data.axis or Vec2()
	self._facing = data.facing or 1
end

-- New - via angle/magnitude
--
function Axis:polar(...)
	self._axis = Vec2:polar(...)
end

---- ---- ---- ----

-- Event: onRqAxis
--
function Axis:onRqAxis(value)
	self:axis(value)
end

---- ---- ---- ----

-- Get heading
--
function Axis:heading()
	return self._axis:heading()
end


-- Get/set facing
--
function Axis:facing(value)
	if value == nil then
		return self._facing
	end

	self._facing = value
end

-- Get/set axis
--
function Axis:axis(value)
	if value == nil then
		return self._axis
	end

	self:ax(value.x or self._axis.x)
	self:ay(value.y or self._axis.y)
end

-- Get/set x-axis
--
function Axis:ax(value)
	if value == nil then
		return self._axis.x
	end

	self._axis.x = value

	--
	if self._axis.x > 0 then
		self._facing = 1
	elseif self._axis.x < 0 then
		self._facing = -1
	end
end

-- Get/set y-axis
--
function Axis:ay(value)
	if value == nil then
		return self._axis.y
	end

	self._axis.y = value
end

return Axis