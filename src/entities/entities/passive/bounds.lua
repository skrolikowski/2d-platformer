-- Bounds Environment
--

local Base   = require 'src.entities.entities.entity'
local Bounds = Base:extend()

function Bounds:new(data)
	Base.new(self, _:merge({
		mixins = {
			transform = {
				x = data.x,
				y = data.y,
				w = data.w or Config.world.tileSize,
				h = data.h or Config.world.tileSize,
			}
		}
	}, data))

	--
	-- properties
	self.order = 2  -- colllision resolution order

	-- flags
	self.isOneWay = data.props['oneway'] or false
end

-- Update
--
function Bounds:update(dt)
	Base.update(self, dt)
end

-- Collision Resolution
--
function Bounds:onResolve(con, nextPos)
	if con.item.mixins['ghost'] then
		return
	end

	if not self:canPassThrough(con.item:aabb()) then
		con:adjust(nextPos)
	end
end

-- Collision Detection
--
function Bounds:onContact(con, other)
	--
end

-- Can other pass through?
--
function Bounds:canPassThrough(aabb)
	return self.isOneWay and
	       not aabb:isAbove(self:aabb(), -0.1)
end

return Bounds