-- (Take) Hit System
--

local Base = require 'src.entities.systems.base'
local Hit  = Base:extend()

-- New
--
function Hit:new(host, data)
	Base.new(self, host, { 'health', 'hit' })
end

---- ---- ---- ----

-- Event: onContact
--
function Hit:onContact(con, other)
	if self:canTakeHit(other) then
		self.host:dispatch('onHit', other)
	end
end

-- Event: onHit
--
function Hit:onHit(other)
	self.host:decreaseHp(other:dmg() or 0)
end

-- Event: onAnimationComplete
--
function Hit:onAnimationComplete(name)
	if name == 'hit' then
		self.host:dispatch('offHit')
	end
end

---- ---- ---- ----

-- Can entity take hit?
--
function Hit:canTakeHit(other)
	local otherCanDmg   = other.isDamage and
	                      other._src.id ~= self.host.id
	local canReceiveDmg = not self.host.isTakingHit and
	                      not self.host.isRolling and
	                      self.host.tHitCooldown == 0

	return ootherCanDamage and canReceiveDmg
end

return Hit