-- Attack Component
--

local Base   = require 'modern'
local Attack = Base:extend()

-- New
--
function Attack:new(host, data)
	self.host = host

	--
	-- properties
	self._atkType    = nil
	self._atkForgive = 0.1
	self._atkDelay   = data.atkDelay or 0.2

	--
	-- flags
	self.isAttacking = false

	-- timers
	self.tAtkReq      = 0
	self.tAtkCooldown = 0
end

-- Update
--
function Attack:update(dt)
	--
	-- attack request timer
	if self.tAtkReq > 0 then
		self.tAtkReq = self.tAtkReq - dt
	else
		self.tAtkReq = 0
	end

	--
	-- update cooldown timer
	if self.tAtkCooldown > 0 then
		self.tAtkCooldown = self.tAtkCooldown - dt
	else
		self.tAtkCooldown = 0
	end
end

---- ---- ---- ----

-- Request Attack
--
function Attack:onRqAttack(atkType)
	self._atkType = atkType
	self.tAtkReq  = self._atkForgive
end

-- Event: onAttack
--
function Attack:onAttack(atkType)
	self._atkType = atkType
	--
	self.isAttacking = true
	self.tAtkReq     = 0 -- reset
end

-- Event: offAttack
--
function Attack:offAttack()
	self._atkType = nil
	--
	self.isAttacking  = false
	self.tAtkCooldown = self._atkDelay
end

---- ---- ---- ----

-- Get/set `atkDelay` value
--
function Attack:atkDelay(value)
	if value == nil then
		return self._atkDelay
	end

	self._atkDelay = value
end

-- Get/set `atkType` value
--
function Attack:atkType(value)
	if value == nil then
		return self._atkType
	end

	self._atkType = value
end

return Attack