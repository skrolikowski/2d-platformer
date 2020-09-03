-- Crouch System
--

local Base   = require 'src.entities.systems.base'
local Crouch = Base:extend()

-- New
--
function Crouch:new(host, data)
	Base.new(self, host, { 'transform', 'crouch' })
	
	--
	-- properties
	self.origHeight   = host._height
	self.crouchHeight = self.origHeight * (data.scale or 0.5)
end

-- Update
--
function Crouch:update(dt)
	--
	-- crouching
	if self:isCrouching() then
		self.host.world:resizeItem(self.host, { h = self.crouchHeight })
	--
	-- standing
	else
		self.host.world:resizeItem(self.host, { h = self.origHeight })
	end
end

-- Is crouching?
--
function Crouch:isCrouching()
	return (
			self.host.isCrouching or
	    	self.host.isRolling
	    ) and
	    not self.host.isLocked
end

-- Is standing?
--
function Crouch:isStanding()
	return self.host.isCrouching or
	       self.host.isRolling
end

return Crouch