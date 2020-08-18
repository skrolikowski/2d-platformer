-- Detection System
--

local Base      = require 'src.entities.systems.base'
local Detection = Base:extend()

-- New
--
function Detection:new(host, data)
	Base.new(self, host, { 'axis', 'transform', 'target' })

	--
	-- properties
	self.world  = host.world
	self.angle  = data.angle   or _.__pi / 4
	self.radius = data.radius  or 50

	-- set component values..
	self.host:detects(data.detects or {})
end

-- Update
--
function Detection:update(dt)
	local cx, cy       = self.host:center()
	local bounds       = AABB:fromCenter(cx, cy, self.radius*2, self.radius*2)
	local prevDetected = _:copy(self.detected or {})

	-- reset
	self.detected = {}

	--
	-- detect range & sight
	self.world:queryBounds(bounds, function(other)
		if self:canDetect(other) and
		   self:isInAngle(other) and
		   self:isInSight(other)
		then
			self.detected[other.id] = other
			--
			self.host:addTarget(other)
		end
	end)

	--
	-- notify of removal
	for id, other in pairs(prevDetected) do
		if not self.detected[id] then
			self.host:removeTarget(other)
		end
	end
end

-- -- Draw
-- --
-- function Detection:draw()
-- 	local heading = self:heading()
-- 	local r, g, b = unpack(Config.color.radar)

-- 	lg.setColor(r, g, b, 0.10)
-- 	lg.arc('fill', 0, 0, self.radius, heading - self.angle, heading + self.angle)
-- 	lg.setColor(r, g, b, 0.35)
-- 	lg.setLineWidth(1)
-- 	lg.arc('line', 0, 0, self.radius, heading - self.angle, heading + self.angle)
-- end

---- ---- ---- ----

-- canDetect
-- ----
-- Can we detect other entity?
--
function Detection:canDetect(other)
	return other.id ~= self.host.id and
	       self.host:detects()[other.name] ~= nil
end

-- isInSight
-- ----
-- Is `other` visible? In line-of-sight?
--
function Detection:isInSight(other)
	local cx, cy = self.host:center()
	local tx, ty = other:center()
	local hits   = {}

	--
	-- raycast to target entities..
	self.world:querySegment(cx, cy, tx, ty, function(hit)
		if hit.id ~= self.host.id then
			table.insert(hits, hit)
		end
	end)

	--
	-- check for line-of-sight..
	for __, hit in pairs(hits) do
		if hit.id == other.id then
			return true
		elseif hit.name == 'bounds' then
			return false
		end
	end

	return false
end

-- isInAngle
-- ----
-- Is `other` within host's POV.
--
function Detection:isInAngle(other)
	local heading   = self:heading()
	local sightLine = Vec2(_.__cos(heading) * self.radius,
		                   _.__sin(heading) * self.radius)
	local toTarget     = other.pos() - self.host.pos()
	local angleBetween = toTarget:angleBetween(sightLine)

	return angleBetween < self.angle
end

-- Get current heading angle.
--
function Detection:heading()
	return self.host:facing() == -1 and _.__pi or 0
end

return Detection