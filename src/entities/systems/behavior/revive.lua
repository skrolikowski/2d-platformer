-- Revive System
--

local Base   = require 'src.entities.systems.base'
local Revive = Base:extend()

-- New
--
function Revive:new(host, data)
	Base.new(self, host, { 'health', 'dead', 'revive' })

	--
	-- properties
	self.delay = data.delay or 3
	self.hpPct = data.hpPct or 0.5
end

-- Update
--
function Revive:update(dt)
	if self:isRevivable() then
		self.host:onRevive()
	end
end

---- ---- ---- ----

-- Event: onAnimationComplete
--
function Revive:onAnimationComplete(name)
	if name == 'revive' then
		self.host:hp(self.host:hpMax() * self.hpPct)
		--
		self.host:dispatch('offHit')
		self.host:dispatch('offDie')
	end
end

---- ---- ---- ----

-- Can entity revive?
--
function Revive:isRevivable()
	return not self.host.isReviving and
	       self.host.isDead and
	       self.host.tDead > self.delay
end

return Revive