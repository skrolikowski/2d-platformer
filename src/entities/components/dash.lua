-- Dash Component
--

local Base = require 'modern'
local Dash = Base:extend()

-- New
--
function Dash:new(host, data)
	self.host = host
	
	--
	-- flags
	self.isDashing = false
end

---- ---- ---- ----

-- Request dashing = true
--
function Dash:onRqDash()
	self.isDashing = true
end

-- Request dashing = false
--
function Dash:offRqDash()
	self.isDashing = false
end

return Dash