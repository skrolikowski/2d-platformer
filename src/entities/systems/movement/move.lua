-- Move System
--

local Base = require 'src.entities.systems.base'
local Move = Base:extend()

-- New
--
function Move:new(host, data)
	Base.new(self, host, { 'axis', 'velocity' })
	
	--
	-- set component values..
	host:spd(data.spd or host._spd)
	host:spdMax(data.spdMax or host._spdMax)
end

-- Update
--
function Move:update(dt)
	--
	-- update vel
	self:updateVX(dt)
	self:updateVY(dt)

	--
	self.host.world:move(
		self.host,
		self.host:pos() + self.host:vel() * dt
	)
end

-- Event: onContact
--
function Move:onContact(con, other)
	if con.norm.y ~= 0 and other.name == 'bounds' then
		self.host:vy(other.vel and other.host:vy() or 0)
	elseif con.norm.x ~= 0 and other.name == 'bounds' then
		self.host:vx(other.vel and other.host:vx() or 0)
	end
end

---- ---- ---- ----

-- VX - axis
--
function Move:byAxis(axis, vel)
	if axis == 0 then
		-- slow-down
		vel = _.__abs(vel) > 1 and vel * 0.35 or 0
	else
		-- full speed
		if self:canMoveX() then
			vel = axis * self.host:spd()
		end
	end

	return vel
end

-- VX
--
function Move:updateVX(dt)
	local ax = self.host:ax()
	local vx = self.host:vx()
	local fx = self.host:fx()
	local spdMax = self.host:spdMax()

	-- apply axis
	vx = self:byAxis(ax, vx)

	-- apply force
	vx = vx + fx * dt

	-- limit speed
	vx = _:clamp(vx, -spdMax, spdMax)

	-- set
	self.host:vx(vx)
	self.host:fx(0)
end

function Move:updateVY(dt)
	local ay = self.host:ay()
	local vy = self.host:vy()
	local fy = self.host:fy()
	-- local spdMax = self.host:spdMax()

	-- apply axis
	-- vy = self:byAxis(ay, vy)

	-- apply force
	vy = vy + fy * dt

	-- limit speed
	-- vy = _:clamp(vy, -spdMax, spdMax)

	-- set
	self.host:vy(vy)
	self.host:fy(0)
end

--
--
function Move:canMoveX()
	return self.host.isRolling or
	      (not self.host.isAttacking and
	       not self.host.isTakingHit and
	       not self.host.isGuarding and
	       not self.host.isReviving and
	       not self.host.isDead and
	       not self.host.isCrouching)
end

return Move