-- Dash System
--

local Base = require 'src.entities.systems.base'
local Dash = Base:extend()

-- New
--
function Dash:new(host)
	Base.new(self, host, { 'velocity', 'dash' })
	
	--
	-- properties
	self.origSpeed = host._spd
	self.dashSpeed = host._spd * host.dashScale
end

-- Update
--
function Dash:update(dt)
	if self.host.isDashing then
		self.host:spd(self.dashSpeed)
	else
		self.host:spd(self.origSpeed)
	end
end

return Dash