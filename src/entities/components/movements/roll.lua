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
		if self.host._isMirrored then
			self.host:vx(-1 * self.host._speed * 0.85)
		else
			self.host:vx( 1 * self.host._speed * 0.85)
		end

		self.host:onCrouch()
	end
end

---- ---- ---- ----

-- Event: onRequestRoll
--
function Roll:onRequestRoll()
	self._isRolling = true
end

-- Event: offRequestRoll
--
function Roll:onRollAnimationComplete()
	self._isRolling = false
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