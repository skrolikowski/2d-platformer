-- Transform Component
--

local Base      = require 'src.entities.components.component'
local Transform = Base:extend()

-- New..
--
function Transform:new()
    self._pos      = Vec2()
    self._width    = 0
    self._height   = 0
	self._bodyType = 'static'
    self._color    = { _:color('white') }
    self._scale    = Vec2(1, 1)
    self._bounds   = nil
end

-- Width/height
--
function Transform:dimensions()
	return self._width  * self._scale.x,
	       self._height * self._scale.y
end

-- Bounding box
--
function Transform:bounds()
	if self._bodyType == 'static' and self._bounds then
		return self._bounds
	end

	--
	local cx, cy = self:pos():unpack()
	local w, h   = self:dimensions()

	self._bounds = AABB:fromContainer(cx-w/2, cy-h/2, w, h)

	return self._bounds
end

-- Container
--
function Transform:container()
	local cx, cy = self:pos():unpack()
	local w, h   = self:dimensions()
	local x, y   = cx-w/2, cy-h/2

	return x, y, w, h
end

---- ---- ---- ----

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

--
--
function Transform:px(value)
	if value == nil then
		return self._pos.x
	end

	self._pos.x = value
end

--
--
function Transform:py(value)
	if value == nil then
		return self._pos.y
	end

	self._pos.y = value
end
----

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

-- Get/set bodyType
--
function Transform:bodyType(value)
	if value == nil then
		return self._bodyType
	end

	self._bodyType = value
end

-- Get/set color
--
function Transform:color(value)
	if value == nil then
		return self._color
	end

	self._color = value
end

-- Get/set scale
--
function Transform:scale(value)
	if value == nil then
		return self._scale
	end

	_scale = Vec2(
		value.x or self._scale.x,
		value.y or self._scale.y
	)
end

--
--
function Transform:sx(value)
	if value == nil then
		return self._scale.x
	end

	self._scale.x = value
end

--
--
function Transform:sy(value)
	if value == nil then
		return self._scale.y
	end

	self._scale.y = value
end
----

return Transform