-- Movement Component
--

local Base     = require 'src.entities.components.component'
local Movement = Base:extend()



-- New..
--
function Movement:new(speed, speedMax)
	--
	-- properties
	self._vel   = Vec2()
	self._force = Vec2()
	self._axis  = Vec2()

	self._speed    = speed    or 800
	self._speedMax = speedMax or 400
end

-- Apply x-force by [Axis x Speed]
--
function Movement:xForce(value)
	--
	-- Cut vel.x if no direction provided
	if value == 0 then
		if _.__abs(self._vel.x) > Config.world.tileSize * 2 then
			self._vel.x = self._vel.x * 0.85
		else
			self._vel.x = 0
		end

		return
	end

	--
	local direction = Util:sign(value)
	local speedDiff = (direction * self._speed) - self._vel.x
	local force     = 0

	if speedDiff ~= 0 then
		if Util:sign(self._vel.x) ~= direction then
			force = direction * self._speed * 2
		else
			force = direction * self._speed
		end

		if not self.host:onGround() then
			force = force * 0.85
		end

		-- apply force
		self:fx(self:fx() + force)
	end
end

-- Update
--
function Movement:update(dt)
	if self.host:onLedge() then
		return
	end
	--

	local world   = self.host.world
	local initVel = self._vel:copy()

	--
	-- apply movement force (x-force)
	self:xForce(self._axis.x)

	-- set velocity
	self._vel = self._vel + self._force * dt
	self._force:scale(0)

	-- limit speed
	self._vel.x = _:clamp(self._vel.x, -self._speedMax, self._speedMax)
	self._vel.y = _:clamp(self._vel.y, -800, 800)

	local dp      = (initVel + self._vel) * dt * 0.5
	local nextPos = self.host.pos + dp

	world:move(self.host, nextPos)
end

---- ---- ---- ----

function Movement:onAxisChange(value)
	self:axis(value)
end

---- ---- ---- ----

-- Get/set movement axis
--
function Movement:axis(value)
	if value == nil then
		return self._axis
	end

	self._axis = Vec2(
		value.x or self._axis.x,
		value.y or self._axis.y
	)
end

--
--
function Movement:ax(value)
	if value == nil then
		return self._axis.x
	end

	self._axis.x = value
end

--
--
function Movement:ay(value)
	if value == nil then
		return self._axis.y
	end

	self._axis.y = value
end
----

-- Get/set velocity
--
function Movement:vel(value)
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
function Movement:vx(value)
	if value == nil then
		return self._vel.x
	end

	self._vel.x = value
end

--
--
function Movement:vy(value)
	if value == nil then
		return self._vel.y
	end

	self._vel.y = value
end
----

-- Get/set force
--
function Movement:force(value)
	if value == nil then
		return self._force
	end

	self._force = Vec2(
		value.x or self._force.x,
		value.y or self._force.y
	)
end

--
--
function Movement:fx(value)
	if value == nil then
		return self._force.x
	end

	self._force.x = value
end

--
--
function Movement:fy(value)
	if value == nil then
		return self._force.y
	end

	self._force.y = value
end



return Movement