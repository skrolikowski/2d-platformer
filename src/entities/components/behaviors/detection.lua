-- Detection Behavioral Component
--

local Base      = require 'src.entities.components.component'
local Detection = Base:extend()

-- New..
--
function Detection:new(angle, radius)
	self._angle  = angle  or _.__pi / 4
	self._radius = radius or 100

	--
	-- indexes
	self._inRange = {}
	self._inSight = {}
end

-- Update..
--
function Detection:update(dt)
	local world     = self.host.world
	local cx, cy    = self.host:center()
	local bounds    = AABB:fromCenter(cx, cy, self._radius, self._radius)
	local prevRange = _:copy(self._inRange)
	local prevSight = _:copy(self._inSight)

	-- reset
	self._inRange = {}
	self._inSight = {}

	--
	-- detect range
	world:queryBounds(bounds, function(other)
		if self:canDetect(other) and self:isInAngle(other) then
			self:onRangeContact(other)
		end
	end)

	--
	-- detect sight
	for id, other in pairs(self._inRange) do
		if self:isInSight(other) then
			self:onSightContact(other)
		end
	end

	--
	-- notify of range exit
	for id, other in pairs(prevRange) do
		if not self._inRange[id] then
			self:offRangeContact(other)
		end
	end

	--
	-- notify of sight exit
	for id, other in pairs(prevSight) do
		if not self._inSight[id] then
			self:offSightContact(other)
		end
	end
end

-- Draw
--
function Detection:draw()
	local cx, cy  = self.host:center()
	local heading = self:heading()
	local r, g, b = unpack(Config.color.radar)

	lg.setColor(r, g, b, 0.10)
	lg.arc('fill', cx, cy, self._radius, heading - self._angle, heading + self._angle)
	lg.setColor(r, g, b, 0.35)
	lg.setLineWidth(1)
	lg.arc('line', cx, cy, self._radius, heading - self._angle, heading + self._angle)
end

---- ---- ---- ----

-- Event: onRangeContact
--
function Detection:onRangeContact(other)
	if not self._inRange[other.id] then
		--
		-- notify
		self.host:behavior():onRangeContact(other)
	end

	self._inRange[other.id] = other
end

-- Event: offRangeContact
--
function Detection:offRangeContact(other)
	self._inRange[other.id] = nil

	-- notify
	self.host:behavior():offRangeContact(other)
end

-- Event: onSightContact
--
function Detection:onSightContact(other)
	if not self._inSight[other.id] then
		--
		-- notify
		self.host:behavior():onSightContact(other)
	end

	self._inSight[other.id] = other
end

-- Event: offSightContact
--
function Detection:offSightContact(other)
	self._inSight[other.id] = nil

	-- notify
	self.host:behavior():offSightContact(other)
end

---- ---- ---- ----

-- Can we detect other entity?
--
function Detection:canDetect(other)
	return other.id ~= self.host.id and
	       other._bodyType == 'kinematic'
end

-- Is `other` in line of sight?
--
function Detection:isInSight(other)
	local world  = self.host.world
	local cx, cy = self.host:center()
	local tx, ty = other:center()
	local hits   = {}
	--
	-- raycast to target entities..
	world:querySegment(cx, cy, tx, ty, function(hit)
		table.insert(hits, hit)
	end)

	--
	-- record if target is visible
	return #hits > 0 and hits[1].id == other.id
end

-- Is `other` in range/angle?
--
function Detection:isInAngle(other)
	local heading   = self:heading()
	local sightLine = Vec2(_.__cos(heading) * self._radius,
		                   _.__sin(heading) * self._radius)
	local toTarget     = other._pos - self.host._pos
	local angleBetween = toTarget:angleBetween(sightLine)

	return angleBetween < self._angle
end

---- ---- ---- ----

-- Get/set facing direction
--
function Detection:heading()
	return self.host:facing() == -1 and _.__pi or 0
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