-- Aim (Ranged) Component
--

local Base = require 'modern'
local Aim  = Base:extend()

-- New
--
function Aim:new(host, data)
	self.host = host
	
	--
	-- flags
	self.isAiming = false
end

-- Request range mode
--
function Aim:onRqAim()
	self.isAiming = true
end

-- Request standard mode
--
function Aim:offRqAim()
	self.isAiming = false
end

return Aim