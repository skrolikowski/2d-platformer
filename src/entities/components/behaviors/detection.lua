-- Detection Behavioral Component
--

local Base      = require 'src.entities.components.component'
local Detection = Base:extend()

-- New..
--
function Detection:new(affects, angle, radius)
	self._affects = Util:toBoolean(affects or {})
	self._angle   = angle or _.__pi / 4
	self._radius  = radius or 50
end

-- Update..
--
function Detection:update(dt)
	local world  = self.host.world
	local cx, cy = self.host:center()
	local bounds = AABB:fromCenter(cx, cy, self._radius, self._radius)
	local others = {}

	--
	-- process others in range..
	world:queryBounds(bounds, function(other)
		--
		--
		if self._affects[other.name] then
			local tx, ty = other:center()
			local hits   = {}

			-- raycast to target entities..
			world:querySegment(cx, cy, tx, ty, function(hit)
				table.insert(hits, hit)
			end)

			--
			-- record if target is visible
			if #hits > 0 and hits[1].id == other.id then
				table.insert(others, other)
			end
		end
	end)

	--
	-- TODO: check if within `_angle`
end

---- ---- ---- ----

-- Get/set affects
--
function Detection:affects(value)
	if value == nil then
		return self._affects
	end

	self._affects = value
end

-- Get/set angle
--
function Detection:angle(value)
	if value == nil then
		return self._angle
	end

	self._angle = value
end

-- Get/set radius
--
function Detection:radius(value)
	if value == nil then
		return self._radius
	end

	self._radius = value
end

return Detection