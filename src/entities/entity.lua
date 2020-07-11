-- Base Entity
--

local Modern = require 'vendor.modern'
local Entity = Modern:extend()

function Entity:new(data)
	self.id   = Util:uuid()
	self.name = data.name

	--
	-- properties
	self.pos      = Vec2(data.x, data.y)
	self.width    = data.width
	self.height   = data.height
	self.bodyType = data.bodyType or 'static'
	self.color    = data.color or { _:color('white') }

	-- scaling
	self.sx = data.sx or 1
	self.sy = data.sx or 1
end

-- Teardown
--
function Entity:destroy()
    self.remove = true
end

-- Center position
--
function Entity:center()
	return self.pos:unpack()
end

-- Width/height
--
function Entity:dimensions()
	return self.width  * self.sx,
	       self.height * self.sy
end

-- Bounding box
--
function Entity:bounds()
	if self.bodyType == 'static' and self._bounds then
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
	local r, g, b = unpack(self.color)

	lg.setColor(r, g, b, 0.33)
	lg.rectangle('fill', self:container())
end

---- ---- ---- ----

--
--
function Entity:px(value)
	if value == nil then
		return self.pos.x
	end

	self.pos.x = value
end

--
--
function Entity:py(value)
	if value == nil then
		return self.pos.y
	end

	self.pos.y = value
end

return Entity