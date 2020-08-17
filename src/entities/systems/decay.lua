-- Decay System
--

local Base  = require 'src.entities.systems.base'
local Decay = Base:extend()

-- New
--
function Decay:new(host, data)
	Base.new(self, host, { 'health' })
	--

	local decayRate = data.rate or 0.35
	local decayPct  = data.pct  or 1

	self.timer = Timer.new()
	self.timer:every(decayRate, function()
		self:decay(decayPct)
	end)
end

-- Decay
--
function Decay:decay(pct)
	self.host:decreaseHp(_.__ceil(self.host:hp() * pct))
end

-- Teardown
--
function Decay:destroy()
	self.timer:clear()
end

-- Update
--
function Decay:update(dt)
	self.timer:update(dt)
end

return Decay