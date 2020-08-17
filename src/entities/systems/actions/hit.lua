-- Hit Action System
--

local Base = require 'src.entities.systems.base'
local Hit  = Base:extend()

-- New
--
function Hit:new(host, data)
	Base.new(self, host, { 'health', 'damage' })

	--
	-- properties
	self.affects = Util:toBoolean(data.affects or {})
end

---- ---- ---- ----

-- Event: onContact
--
function Hit:onContact(con, other)
	if self:canTakeDamage(other) then
		self.host:dispatch('onHit', other)
	end
end

-- Event: onHit
--
function Hit:onHit(other)
	self.host:decreaseHp(
		self.host:damage(other) or 0)
end

-- Event: onAnimationComplete
--
function Hit:onAnimationComplete(name)
	if name == 'hit' then
		self.host:dispatch('offHit')
	end
end

---- ---- ---- ----

-- Can entity take damage?
--
function Hit:canTakeDamage(other)
	return not self.host.isTakingDamage and
		   not self.host.isRolling and
		   self.host.tDmgCooldown  == 0 and
		   self.affects[other.name] ~= nil
end

return Hit