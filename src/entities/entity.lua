-- Base Entity
--

local Modern = require 'vendor.modern'
local Entity = Modern:extend()

function Entity:new(data)
	self.id   = Util:uuid()
	self.name = data.name

	--
	-- properties
	self._pos      = Vec2(data.x, data.y)
	self._width    = data.width
	self._height   = data.height
	self._bodyType = data.bodyType or 'static'
	self._color    = data.color or { _:color('white') }

	-- scaling
	self._sx = data.sx or 1
	self._sy = data.sx or 1

	-- flags
	self._remove = false
end

-- Teardown
--
function Entity:destroy()
    self.remove = true
end

-- Center position
--
function Entity:center()
	return self._pos:unpack()
end

-- Width/height
--
function Entity:dimensions()
	return self._width  * self._sx,
	       self._height * self._sy
end

-- Bounding box
--
function Entity:bounds()
	if self._bodyType == 'static' and self._bounds then
		return self._bounds
	end

	--
	local cx, cy = self:center()
	local w, h   = self:dimensions()

	self._bounds = AABB:fromContainer(cx-w/2, cy-h/2, w, h)

	return self._bounds
end

-- Containing box
--
function Entity:container()
	local cx, cy = self:center()
	local w, h   = self:dimensions()
	local x, y   = cx-w/2, cy-h/2

	return x, y, w, h
end

-- Update
--
function Entity:update(dt)
	--
end

-- Draw
--
function Entity:draw()
	-- local r, g, b = unpack(self.color)

	-- lg.setColor(r, g, b, 0.33)
	-- lg.rectangle('fill', self:container())
end

---- ---- ---- ----

-- Event: onUpdate
-- Update entity pos/dimensions in World.
--
function Entity:onUpdate(data)
	self._pos.x  = data.x or self._pos.x
	self._pos.y  = data.y or self._pos.y
	self._width  = data.w or self._width
	self._height = data.h or self._height
	--
	self.world:update(self,
		self._pos.x, self._pos.y,
		self._width, self._height
	)
end

---- ---- ---- ----

-- Get/set x-position
--
function Entity:px(value)
	if value == nil then
		return self._pos.x
	end

	self:onUpdate({ x = value })
end

-- Get/set y-position
--
function Entity:py(value)
	if value == nil then
		return self._pos.y
	end

	self:onUpdate({ y = value })
end

-- Get/set x-scale
--
function Entity:sx(value)
	if value == nil then
		return self._sx
	end

	self._sx = value
end

-- Get/set y-scale
--
function Entity:sy(value)
	if value == nil then
		return self._sy
	end

	self._sy = value
end

-- Get/set width
--
function Entity:width(value)
	if value == nil then
		return self._width * self._sx
	end

	self:onUpdate({ w = value })
end

-- Get/set height
--
function Entity:height(value)
	if value == nil then
		return self._height * self._sy
	end

	self:onUpdate({ h = value })
end

return Entity