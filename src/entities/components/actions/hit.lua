-- (Take) Hit Component
--

local Base = require 'modern'
local Hit  = Base:extend()

-- New
--
function Hit:new(host, data)
	self.host = host

	--
	-- properties
	self._hitDelay = data.hitDelay or 1.5

	-- flags
	self.isTakingHit = false

	-- timers
	self.tHitCooldown = 0
end

-- Update
--
function Hit:update(dt)
	--
	-- update cooldown timer
	if self.tHitCooldown > 0 then
		self.tHitCooldown = self.tHitCooldown - dt
	else
		self.tHitCooldown = 0
	end
end

---- ---- ---- ----

-- Event: onHit
--
function Hit:onHit(other)
	self.isTakingHit = true
	self.tHitCooldown   = self._hitDelay
end

-- Event: offHit
--
function Hit:offHit()
	self.isTakingHit = false
end

---- ---- ---- ----

-- Get/set `hitDelay` value
--
function Hit:hitDelay(value)
	if value == nil then
		return self._hitDelay
	end

	self._hitDelay = value
end

return Hit