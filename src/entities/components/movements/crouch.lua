-- Crouch Component
--

local Base   = require 'src.entities.components.component'
local Crouch = Base:extend()

-- New..
--
function Crouch:__new(data)
	Base.__new(self, data)
	--
	self._iHeight = self.host:height()
	self._cHeight = self._iHeight / 2
	self._cOffset = (self._iHeight - self._cHeight) / 2
end

-- Update..
--
function Crouch:update(dt)
	if self._isCrouching then
		if self.host:height() ~= self._cHeight then
			self.host:onUpdate({
				y = self.host:py() + self._cOffset,
				h = self._cHeight
			})
		end
	else
		if self.host:height() ~= self._iHeight then
		-- adjust back to init height
			self.host:onUpdate({
				y = self.host:py() - self._cOffset,
				h = self._iHeight
			})
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

-- Event: offRequestCrouch
--
function Crouch:onCrouchAnimationComplete()
	--
end

---- ---- ---- ----

-- Flag check
--
function Crouch:isCrouching()
	return self._isCrouching
end

return Crouch