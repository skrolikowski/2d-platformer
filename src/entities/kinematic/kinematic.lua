-- Kinematic Entity
--

local Base      = require 'src.entities.entity'
local Kinematic = Base:extend()

function Kinematic:new(name, data, ...)
	Base.addMixins(self, ...)
	--
	Base.new(self, name, _:merge(data, {
		bodyType = 'kinematic',
		color    = { _:color('green-500')}
	}))
	--
	-- properties
	self._vel      = Vec2()
	self._force    = Vec2()
	self._speed    = 100
	self._speedMax = 200
	self._behavior = BM(self)
end

-- Teardown
--
function Kinematic:destroy()
	self._behavior:destroy()
	--
	self.world:remove(self)
end

-- Update
--
function Kinematic:update(dt)
	self._behavior:update(dt)

	--
	-- update position
	local initVel = self._vel:copy()

	-- query mixins
	self:onRequestUpdate(dt)

	-- apply forces to velocity
	self._vel = self._vel + self._force * dt
	self._force:scale(0)

	-- limit speed
	self._vel.x = _:clamp(self._vel.x, -self._speedMax, self._speedMax)
	self._vel.y = _:clamp(self._vel.y, -600, 600)

	local dp      = (initVel + self._vel) * dt * 0.5
	local nextPos = self._pos + dp

	self:onRequestMove(nextPos)
end

-- Draw
--
function Kinematic:draw()
	local cx, cy  = self:center()
	local r, g, b = unpack(self._color)

	lg.setColor(r, g, b, 0.5)
	lg.setLineWidth(1)

	lg.circle('line', cx, cy, 3)
	lg.rectangle('line', self:container())
end

---- ---- ---- ----

-- Event: onMove
-- Move entity in World.
--
function Kinematic:onRequestMove(nextPos)
	self.world:move(self, nextPos)
end

---- ---- ---- ----

-- Get/set behavior manager
--
function Kinematic:behavior()
	return self._behavior
end

-- Get/set velocity
--
function Kinematic:vel(value)
	if value == nil then
		return self._vel
	end

	self._vel = Vec2(
		value.x or self._vel.x,
		value.y or self._vel.y
	)
end

--
--
function Kinematic:vx(value)
	if value == nil then
		return self._vel.x
	end

	self._vel.x = value
end

--
--
function Kinematic:vy(value)
	if value == nil then
		return self._vel.y
	end

	self._vel.y = value
end

-- Get/set force
--
function Kinematic:force(value)
	if value == nil then
		return self._force
	end

	self._force = Vec2(
		value.x or self._force.x,
		value.y or self._force.y
	)
end

-- Get/set x-force
--
function Kinematic:fx(value)
	if value == nil then
		return self._force.x
	end

	self._force.x = value
end

-- Get/set y-force
--
function Kinematic:fy(value)
	if value == nil then
		return self._force.y
	end

	self._force.y = value
end

return Kinematic