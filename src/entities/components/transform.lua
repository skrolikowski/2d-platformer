-- Transform Component
--

local Base      = require 'modern'
local Transform = Base:extend()

-- New
--
function Transform:new(host, data)
	self.host = host

	local _x = data.x or 0
	local _y = data.y or 0
	local _w = data.w or Config.world.tileSize
	local _h = data.h or Config.world.tileSize

	--
	-- propertes
	self._pos    = Vec2(_x, _y)
	self._width  = _w
	self._height = _h
	self._aabb   = AABB:fromCenter(_x, _y, _w, _h)

	-- scaling
	self._sx = data.sx or 1
	self._sy = data.sy or 1
end

-- Center position
--
function Transform:center()
	return self._pos:unpack()
end

-- Dimensions
--
function Transform:dimensions()
	return self._width, self._height
end

-- Containing box
--
function Transform:container()
	local cx, cy = self:center()
	local w, h   = self:dimensions()
	local x, y   = cx-w/2, cy-h/2

	return x, y, w, h
end

-- Axis-aligned bounding box
--
function Transform:aabb(value)
	if value == nil then
		return self._aabb
	end

	self._aabb = value
end

-- Get/set position
--
function Transform:pos(value)
	if value == nil then
		return self._pos
	end

	self._pos = Vec2(
		value.x or self._pos.x,
		value.y or self._pos.y
	)
end

-- Get/set x-position
--
function Transform:px(value)
	if value == nil then
		return self._pos.x
	end

	self._pos.x = value
end

-- Get/set y-position
--
function Transform:py(value)
	if value == nil then
		return self._pos.y
	end

	self._pos.y = value
end

-- Get/set scale
--
function Transform:scale(value)
	if value == nil then
		return self._sx, self._sy
	end

	self._sx = value.x or self._sx
	self._sy = value.y or self._sy
end

-- Get/set x-scale
--
function Transform:sx(value)
	if value == nil then
		return self._sx
	end

	self._sx = value
end

-- Get/set y-scale
--
function Transform:sy(value)
	if value == nil then
		return self._sy
	end

	self._sy = value
end

-- Get/set width
--
function Transform:width(value)
	if value == nil then
		return self._width
	end

	self._width = value
end

-- Get/set height
--
function Transform:height(value)
	if value == nil then
		return self._height
	end

	self._height = value
end

return Transform