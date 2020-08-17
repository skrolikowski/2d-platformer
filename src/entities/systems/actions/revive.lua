-- Revive System
--

local Base   = require 'src.entities.systems.base'
local Revive = Base:extend()

-- New
--
function Revive:new(host, data)
	Base.new(self, host, {
		health = data.heath  or {},
		death  = data.death  or {},
		revive = data.revive or {},
	})

	self.reviveDelay = data.reviveDelay or 3
end

-- Update
--
function Revive:update(dt)
	if self:isRevivable() then
		self.host:dispatch('onRevive')
	end
end

---- ---- ---- ----

-- Event: onAnimationComplete
--
function Revive:onAnimationComplete(name)
	if name == 'revive' then
		self.host:hp(self.host:hpMax())
		--
		self.host:dispatch('offDie')
	end
end

---- ---- ---- ----

-- Can entity revive?
--
function Revive:isRevivable()
	return self.host.isReviveReq and
	       not self.host.isReviving and
	       self.host.tDead > self.reviveDelay
end

return Revive