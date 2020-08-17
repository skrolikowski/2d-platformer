-- Damage Component
--

local Base   = require 'modern'
local Damage = Base:extend()

-- New
--
function Damage:new(host, data)
	self.host = host

	--
	-- properties
	self._dmgDelay = data.dmgDelay or 1.5
	self._dmgIndex = {
		--TODO:
		player   = 50,
		skeleton = 10
	}

	--
	-- flags
	self.isTakingDamage = false

	-- timers
	self.tDmgCooldown = 0
end

-- Update
--
function Damage:update(dt)
	--
	-- update cooldown timer
	if self.tDmgCooldown > 0 then
		self.tDmgCooldown = self.tDmgCooldown - dt
	else
		self.tDmgCooldown = 0
	end
end

---- ---- ---- ----

-- Event: onHit
--
function Damage:onHit(other)
	self.isTakingDamage = true
	self.tDmgCooldown   = self._dmgDelay
end

-- Event: offHit
--
function Damage:offHit()
	self.isTakingDamage = false
end

---- ---- ---- ----

-- Get damage amount from `other`
--
function Damage:damage(other)
	local source = other

	-- obtain source..
	if source.name == 'attack' then
		source = source.attacker
	end

	return self._dmgIndex[source.name] or 0
end

-- Get/set `dmgDelay` value
--
function Damage:dmgDelay(value)
	if value == nil then
		return self._dmgDelay
	end

	self._dmgDelay = value
end

return Damage