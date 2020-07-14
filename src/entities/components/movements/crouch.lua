-- Crouch Component
--

local Base   = require 'src.entities.components.component'
local Crouch = Base:extend()

-- New..
--
function Crouch:__new(data)
	Base.__new(self, data)
	--
	-- properties
	self._initHeight   = self.host:height()
	self._crouchHeight = self._initHeight / 2
	self._crouchOffset = (self._initHeight - self._crouchHeight) / 2

	-- flags
	self._isCrouching = false
end

---- ---- ---- ----

-- Update..
--
function Crouch:onRequestUpdate(dt)
	if self._isCrouching then
		self.host:vx(0)
		--
		self:onCrouch()
	else
		self:onStand()
	end
end

-- Event: onCrouch
-- Shrink height and offset y.
--
function Crouch:onCrouch()
	if self.host:height() ~= self._crouchHeight then
		self.host:onUpdate({
			y = self.host:py() + self._crouchOffset,
			h = self._crouchHeight
		})
	end
end

-- Event: onStand
-- Shrink height and offset y.
--
function Crouch:onStand()
	if self.host:height() ~= self._initHeight then
		self.host:onUpdate({
			y = self.host:py() - self._crouchOffset,
			h = self._initHeight
		})
	end
end

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

-- Get/set `_isCrouching` flag
--
function Crouch:isCrouching(value)
	if value == nil then
		return self._isCrouching
	end

	self._isCrouching = value
end

return Crouch