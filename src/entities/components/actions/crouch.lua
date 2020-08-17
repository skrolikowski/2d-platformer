-- Crouch Component
--

local Base   = require 'modern'
local Crouch = Base:extend()

-- New
--
function Crouch:new(host, data)
	self.host = host
	
	--
	-- properties
	self.crouchScale = 0.5

	-- flags
	self.isCrouching = false
end

---- ---- ---- ----

-- Request crouch.
--
function Crouch:onRqCrouch()
	self.isCrouching = true
end

-- Request stand.
--
function Crouch:offRqCrouch()
	self.isCrouching = false
end

return Crouch