-- (Take) Hit System
--

local Base = require 'src.entities.systems.base'
local Hit  = Base:extend()

-- New
--
function Hit:new(host, data)
	local systems = {
		health = { },
	    hit    = { delay = data.delay or host.__hitDelay }
	}

	-- can be stunned?
	if data.stun then
		systems['stun'] = data.stun
	end

	--
	Base.new(self, host, systems)
end

---- ---- ---- ----

-- Event: onContact
--
function Hit:onContact(con, other)
	if self:canTakeHit(other) then
		--TODO: calculate damage
		--TODO: apply status affect?
		self.host:decreaseHp(other:dmg())
		self.host:dispatch('onHit', other)
	end
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
	return other.mixins['damage'] and
	       not self.host.isTakingHit and
	       not self.host.isRolling and
	       self.host.tHitCooldown == 0 and
	       not self:isFriendlyFire(other)
end

function Hit:isFriendlyFire(other)
	local source = other.mixins['source'] and other._src.id or other.id

	return source.id == self.host.id
end

return Hit