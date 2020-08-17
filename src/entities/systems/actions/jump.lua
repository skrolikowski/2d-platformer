-- Jump System
--

local Base = require 'src.entities.systems.base'
local Jump = Base:extend()

-- New
--
function Jump:new(host, data)
	Base.new(self, host, { 'jump', 'velocity' })
	--
end

-- Update
--
function Jump:update(dt)
	if self.host.jumpTerm then
		if self.host:vy() < -self.host.jumpSpeed * 0.5 then
			self.host:offJump()
			self.host:vy(-self.host.jumpSpeed * 0.5)
		end
	end


	if self:jumpRequested() then
		if self:canJump() then
			self.host:onJump()
			self.host:vy(self.host:vy() - self.host.jumpSpeed)
		end
	end
end

---- ---- ---- ----

-- Can perform jump.
--
function Jump:canJump()
	local isOnGround   = self.host.isOnGround or self.host.tLastGround < 0.1
	local isCrouching  = self.host.isCrouching
	local reachedLimit = self.host.jumpNum >= self.host.jumpMax

	return isOnGround and
	       not isCrouching and
	       not reachedLimit
end

-- Has jump been requested?
--
function Jump:jumpRequested()
	return self.host.tJumpReq > 0
end

return Jump