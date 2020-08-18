-- Attack Behavior
--

local Base   = require 'src.entities.behaviors.base'
local Attack = Base:extend()

-- New
--
function Attack:new(manager, data)
	Base.new(self, 'attack', manager, {
		attack    = {
			delay = data.delay or 0.75
		},
		detection = {
			angle   = data.angle   or _.__pi/4,
			radius  = data.radius  or 50,
			detects = data.detects or { 'player' },
		},
	})
end

-- Clear
--
function Attack:clear()
	self.host:dispatch('offAttack')
end

-- Pass
--
function Attack:pass()
	return self.host:hasTargets()
end

-- Execute behavior
--
function Attack:execute(dt)
	self.host:onRqAttack()
	
	return true
end

return Attack