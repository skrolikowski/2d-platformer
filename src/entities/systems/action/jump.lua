-- Jump System
--

local Base = require 'src.entities.systems.base'
local Jump = Base:extend()

-- New
--
function Jump:new(host, data)
	Base.new(self, host, { 'jump', 'velocity' })
	
	--
	-- properties
	self.canDouble = data.canDouble or false
end

-- Update
--
function Jump:update(dt)
	--
	-- onTerminate..
	if self.host.jumpTerm then
		if self.host:vy() < -self.host.jumpSpeed * 0.5 then
			self.host:vy(-self.host.jumpSpeed * 0.5)
		end
	end

	-- onRequest..
	if self:jumpRequested() then
		if self:canDoubleJump() then
		--
		-- double
			self.host:onJump()
			self.host:vy(-self.host.jumpSpeed)
		elseif self:canJump() then
		--
		-- single
			self.host:onJump()
			self.host:vy(self.host:vy() - self.host.jumpSpeed)
		end
	end

	if self.host.isJumping then
	--
	-- disable `isJumping` flag?
		if self.host:vy() > self.host:spdMax() then
			self.host:offJump()
		end
	end
end

---- ---- ---- ----

-- Can perform jump
--
function Jump:canJump()
	local isOnGround  = self.host.isOnGround or self.host.tLastGround < 0.1
	local isCrouching = self.host.isCrouching

	return isOnGround and
	       not isCrouching
end

-- Can perform double jump
--
function Jump:canDoubleJump()
	return not self.host.isDJumping and
	       self.host.isJumping and
	       self.canDouble
end

-- Has jump been requested?
--
function Jump:jumpRequested()
	return self.host.tJumpReq > 0
end

return Jump