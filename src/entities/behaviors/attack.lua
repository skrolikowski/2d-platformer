-- Attack Behavior
--

local Base   = require 'src.entities.behaviors.behavior'
local Attack = Base:extend()

-- New
--
function Attack:new(...)
	Base.new(self, 'fight', ...)
	--

	-- default
	self.isAttacking = true
end

-- Pass
--
function Attack:pass()
	return self.isAttacking
end

-- Execute behavior
--
function Attack:execute(dt)
	self.host:onRequestAttack()
end

---- ---- ---- ----

function Attack:onSightContact(other)
	self.isAttacking = true
end

function Attack:offSightContact(other)
	self.isAttacking = false
end

return Attack