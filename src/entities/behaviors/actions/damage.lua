-- Damage Behavior
--

local Base   = require 'src.entities.behaviors.base'
local Damage = Base:extend()

-- New
--
function Damage:new(manager, data)
	Base.new(self, 'damage', manager, { })
end

-- Pass
--
function Damage:pass()
	return self.host.isDead or
	       self.host.isReviving or
	       self.host.isTakingHit or
	       self.host.isStunned
end

-- Execute behavior
--
function Damage:execute(dt)
	return true
end

return Damage