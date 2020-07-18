-- Patrol Behavior
--

local Base   = require 'src.entities.behaviors.behavior'
local Patrol = Base:extend()

-- New
--
function Patrol:new(...)
	Base.new(self, 'patrol', ...)
	--

	self.timer:script(function(wait)
		while true do
			--
			-- active
			self.isPatrolling = true
			wait(2)

			-- inactive
			self.host:ax(0)
			self.isPatrolling = false
			wait(1)
		end
	end)
end

-- Pass
--
function Patrol:pass()
	return self.isPatrolling
end

-- Execute behavior
--
function Patrol:execute(dt)
	self.host:ax(self.host:facing())

	return true
end

---- ---- ---- ----

-- Event: onContact
--
function Patrol:onContact(con)
	if con.norm.x ~= 0 then
		self.host:ax(con.norm.x)
	end
end

return Patrol