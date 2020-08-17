local Modern  = require 'modern'
local Contact = Modern:extend()

-- new contact
--
function Contact:new(item, other)
	self.item  = item
	self.other = other
	self.order = self.other.order
end

-- Test for contact!
-- aabb#1 (dx, dy) => aabb#2
--
function Contact:project(dx, dy)
	local nextBB = self.item:aabb():translate(dx, dy)
	local px, py = nextBB:project(self.other:aabb())

	if px == 0 and py == 0 then
		return false
	end

	self.move = Vec2(dx, dy)
	self.proj = Vec2(px, py)
	self.norm = Vec2(px, py):normalize()

	return self
end

-- Adjust target position so no overlap occurs.
--
function Contact:adjust(target)
	target.x = target.x + self.proj.x
	target.y = target.y + self.proj.y

	return target
end

return Contact