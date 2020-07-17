-- Attack Component
--

local Base   = require 'src.entities.components.component'
local Attack = Base:extend()

-- New..
--
function Attack:new()
	--
	-- properties
	self._attackDelay = 0.15
	
	-- flags
	self._isAttacking = false

	-- timers
	self._tCooldown = 0
end

-- Update
--
function Attack:update(dt)
	--
	-- update delay timer
	self._tCooldown = self._tCooldown > 0 and self._tCooldown - dt or 0
end

---- ---- ---- ----

-- Event: onRequestAttack
--
function Attack:onRequestAttack()
	--
	if self:canAttack() then
		self._isAttacking = true

		--
		-- TODO: projectile
	end
end

-- Event: onAttackAnimationComplete
-- Attack animation has completed.
--
function Attack:onAttackAnimationComplete()
	self._isAttacking = false
	self._tCooldown   = self._attackDelay
end

---- ---- ---- ----

-- Can we attack?
--
function Attack:canAttack()
	return not self._isAttacking and self._tCooldown <= 0
end

-- Get/set `_isAttacking` flag
--
function Attack:isAttacking(value)
	if value == nil then
		return self._isAttacking
	end
	
	self._isAttacking = value
end

return Attack