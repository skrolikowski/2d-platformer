-- (Take) Stun Component
--

local Base = require 'modern'
local Stun = Base:extend()

-- New
--
function Stun:new(host, data)
	self.host = host

	--
	-- properties
	self._stunDelay = data.delay or 3

	-- flags
	self.isStunned = false
end

-- Event: onStun
--
function Stun:onStun(other)
	self.isStunned = true
end

-- Event: offStun
--
function Stun:offStun()
	self.isStunned = false
end

return Stun