-- Patrol Behavior
--

local Base   = require 'src.entities.behaviors.base'
local Patrol = Base:extend()

-- New
--
function Patrol:new(manager, data)
	Base.new(self, 'patrol', manager, { 'move' })

	--
	-- flags
	self.isPatrolling = false
end

-- Pass
--
function Patrol:pass()
	return true
end

-- Clear
--
function Patrol:clear()
	self:offPatrol()
end

-- Execute behavior
--
function Patrol:execute(dt)
	self:onPatrol()
end

---- ---- ---- ----

-- Event: onPatrol
--
function Patrol:onPatrol()
	self.isPatrolling = true
	self.host:dispatch('onRqAxis', { x = self.host:facing() })
end

-- Event: offPatrol
--
function Patrol:offPatrol()
	if self.isPatrolling then
		self.isPatrolling = false
		self.host:dispatch('onRqAxis', { x = 0 })
	end
end

-- Event: onContact
--
function Patrol:onContact(con, other)
	if self:isWall(con, other) then
		self.host:facing(con.norm.x)
	end
end

--
--
function Patrol:isWall(con, other)
	return con.norm.x ~= 0 and other.name == 'bounds'
end

return Patrol