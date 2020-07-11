local Modern  = require 'vendor.modern'
local Contact = Modern:extend()

-- new contact
--
function Contact:new(item, other)
	self.item  = item
	self.other = other
	self.order = self.other.order

	-- save bounds
	--  for easy access
	self.bb1 = item:bounds()
	self.bb2 = other:bounds()
end

-- Test for contact!
-- bb1 (dx, dy) => bb2
--
function Contact:project(dx, dy)
	local nextBB = self.bb1:translate(dx, dy)
	local px, py = nextBB:project(self.bb2)

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
	if self.item:onLedge() then
		target.x = target.x + self.proj.x
		target.y = self.item.pos.y + (self.bb2.top - self.bb1.top)
	else
		target.x = target.x + self.proj.x
		target.y = target.y + self.proj.y
	end

	return target
end

return Contact