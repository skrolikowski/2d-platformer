-- Death Component
--

local Base  = require 'modern'
local Death = Base:extend()

-- New
--
function Death:new(host, data)
	self.host = host

	--
	-- flags
	self.isDead = false

	-- timers
	self.tDead = 0
end

-- Update
--
function Death:update(dt)
	self.tDead = self.isDead and self.tDead + dt or 0
end

-- Event: onDie
--
function Death:onDie()
	self.isDead = true
end

-- Event: offDie
--
function Death:offDie()
	self.isDead = false
end

return Death