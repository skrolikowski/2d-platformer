-- Slope Environment
--

local Base  = require 'src.entities.entity'
local Slope = Base:extend()

-- New slope bounds
--
function Slope:new(data)
	assert(data.shape == 'polyline', 'Must be a polyline shape.')
	--
	-- properties
	self.segment = Segment(
		Vec2(data.polyline[1]),
		Vec2(data.polyline[2])
	)
	self.order = 1

	local bounds = self.segment:bounds()
	local cx, cy = bounds:center()
	local w, h   = bounds:dimensions()

	--
	Base.new(self, _:merge(data, {
		name   = 'slope',
		color  = { _:color('blue-300') },
		x      = cx,
		y      = cy,
		width  = w,
		height = h
	}))
end

-- Resolve collision
--
function Slope:resolve(con, target)
	local cx, cy  = con.item:center()
	local w, h    = con.item:dimensions()
	local base    = Vec2(cx, cy + h/2)
	local segment = Segment(cx, base.y+5, cx, cy)
	local anchor  = self.segment:vsSegment(segment)

	if anchor then
		con.item:onGroundContact(con.other, con)
		--
		con.item:vx(con.item:vx() * 0.95)
		con.item:vy(0)

		target.y = target.y + (anchor - base).y

		return false
	end
end

-- Are bounding boxes touching?
--
function Slope:isTouching(other)
	return self:bounds():contains(other:bounds())
end

-- Draw
--
function Slope:draw()
	lg.setColor(1,1,1,1)
	lg.line(self.segment:unpack())
	--
	Base.draw(self)
end

return Slope