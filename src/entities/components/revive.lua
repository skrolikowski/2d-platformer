-- Revive Component
--

local Base   = require 'modern'
local Revive = Base:extend()

-- New
--
function Revive:new(host, data)
	self.host = host

	--
	-- flags
	self.isReviving = false
end

-- Event: onRevive
--
function Revive:onRevive()
	self.isReviving = true
end

-- Event: offRevive
--
function Revive:offRevive()
	self.isReviving  = false
	self.isReviveReq = false
end

-- Event: onAnimationComplete
--
function Revive:onAnimationComplete(name)
	if name == 'revive' then
		self:offRevive()
	end
end

return Revive