-- Death System
--

local Base  = require 'src.entities.systems.base'
local Death = Base:extend()

-- New
--
function Death:new(host, data)
	Base.new(self, host, { 'health', 'death' })

	--
	-- timers
	self.tRemove = data.remove or 3
end

-- Update
--
function Death:update(dt)
	--
	-- clean up
	if self:shouldRemove() then
		self.host:destroy()
	--
	-- check for death
	elseif self:isDying() then
		self.host:dispatch('onDie')
	end
end

-- Event: onDie
--
function Death:onDie()
	self.host:hp(0)
end

-- Is entity dying?
--
function Death:isDying()
	return not self.host.isDead and self.host:hp() <= 0
end

-- Should remove from world?
--
function Death:shouldRemove()
	return not self.host:hasSystem('revive') and
	       self.host.tDead > self.tRemove
end

return Death