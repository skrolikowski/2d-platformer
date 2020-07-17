-- Jump Component
-- Can entity jump?
--

local Base = require 'src.entities.components.component'
local Jump = Base:extend()

-- New..
--
function Jump:new(height, dt)
	height = height or Config.world.tileSize * 6
	dt     = dt or 0.4
	--
	-- properties
	self._jumpCount  = { num = 0, max = 1}
	self._jumpSpeed  = _.__sqrt(2 * (2 * height / dt^2) * height)
	self._jumpDelay  = 0.15

	-- timers
	self._tJump   = 0
	self._tGround = 0
end

---- ---- ---- ----

-- Event: onRequestUpdate
--
function Jump:onRequestUpdate(dt)
	--
	-- update delay timer
	self._tJump = self._tJump > 0 and self._tJump - dt or 0
	
	-- update "last ground touch"
	if self.host:onGround() then
		self._tGround = 0
	else
		self._tGround = self._tGround + dt
	end

	-- jump limit check
	if self._jumpCount.num < self._jumpCount.max then
		--
		-- jump request check
		if self._tJump > 0 then
			self:performJump()
		end
	end
end

-- Event: onGround
-- Regain jump ability
--
function Jump:onGroundContact(con)
	self._jumpCount.num = self._jumpCount.num - 1
end

-- Event: onWall
-- Regain jump ability
--
function Jump:onWallContact(con)
	self._jumpCount.num = self._jumpCount.num - 1
end

-- Event: onRequestJump
--
function Jump:onRequestJump()
	self._tJump = self._jumpDelay
end

-- Event: offRequestJump
--
function Jump:offRequestJump()
	if self.host:vy() < -self._jumpSpeed*0.5 then
		self.host:vy(-self._jumpSpeed*0.5)
	end
end

-- Event: onJump action!
--
function Jump:performJump()
	--
	-- onGround
	if self.host:onGround() or self._tGround < 0.1 then
		if self.host._isCrouching then
			--
			-- defer to roll
			self.host:onRequestRoll()
		else
			self._tJump         = 0  -- reset
			self._jumpCount.num = self._jumpCount.num + 1
			--
			self.host:vy(-self._jumpSpeed)
			self.host:onGround(false)
		end
	--
	-- onLedge
	elseif self.host:onLedge() then
		self._tJump         = 0  -- reset
		self._jumpCount.num = self._jumpCount.num + 1
		--
		self.host:vy(-self._jumpSpeed * 0.8)
		self.host:onLedge(false)
	end
end

return Jump