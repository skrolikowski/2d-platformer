-- Roll Component
--

local Base = require 'src.entities.components.component'
local Roll = Base:extend()

-- New..
--
function Roll:__new(data)
	Base.__new(self, data)
	--
	-- flags
	self._isRolling = false
end

-- Event: onRequestUpdate
--
function Roll:onRequestUpdate(dt)
	if self._isRolling then
	-- keep crouch status
		self.host:onCrouch()
	end
end

---- ---- ---- ----

-- Event: onRequestRoll
--
function Roll:onRequestRoll()
	self.host:ax(self.host:facing())
	self._isRolling = true
end

-- Event: onRollAnimationComplete
-- Rolling animation has completed.
--
function Roll:onRollAnimationComplete()
	self._isRolling = false
	self.host:ax(0)
end

---- ---- ---- ----

-- Flag check
--
function Roll:isRolling()
	if value == nil then
		return self._isRolling
	end

	self._isRolling = value
end

return Roll