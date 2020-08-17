-- Crouch System
--

local Base   = require 'src.entities.systems.base'
local Crouch = Base:extend()

-- New
--
function Crouch:new(host)
	Base.new(self, host, { 'transform', 'crouch' })
	
	--
	-- properties
	self.origHeight   = host._height
	self.crouchHeight = self.origHeight * self.host.crouchScale
end

-- Update
--
function Crouch:update(dt)
	if self:isCrouching() then
		self.host.world:resizeItem(self.host, { h = self.crouchHeight })
	else
		self.host.world:resizeItem(self.host, { h = self.origHeight })
	end
end

-- Is crouching?
--
function Crouch:isCrouching()
	return self.host.isCrouching or
	       self.host.isRolling
end

return Crouch