-- Crouch Component
--

local Base   = require 'src.entities.components.component'
local Crouch = Base:extend()

-- New..
--
function Crouch:__new(data)
	Base.__new(self, data)
	--
	self._initHeight = self.host:height()
end

-- Update..
--
function Crouch:update(dt)
	if self._isCrouching then
		self.host:height(self._initHeight / 2)
	else
		if self.host:height() ~= self._initHeight then
			self.host:height(self._initHeight)
		end
	end
end

---- ---- ---- ----

-- Event: onRequestCrouch
--
function Crouch:onRequestCrouch()
	self._isCrouching = true
end

-- Event: offRequestCrouch
--
function Crouch:offRequestCrouch()
	self._isCrouching = false
end

---- ---- ---- ----

-- Flag check
--
function Crouch:isCrouching()
	return self._isCrouching
end

return Crouch