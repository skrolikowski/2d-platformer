-- Jump Component
--

local Base = require 'modern'
local Jump = Base:extend()

-- New
--
function Jump:new(host, data)
	-- mini jump formula
	-- ref: https://2dengine.com/?p=platformers#Jumping
	local height   = data.jumpTile or Config.world.tileSize * 6
	local apexTime = data.apexTime or 0.4
	local g        = 2 * height / apexTime^2
	local initVel  = _.__sqrt(2 * g * height)
	--
	--
	self.host = host

	-- properties
	self.jumpNum     = 0
	self.jumpMax     = 1
	self.jumpSpeed   = initVel
	self.jumpForgive = 0.15

	-- flags
	self.isJumping  = false
	self.isJumpTerm = false

	-- timers
	self.tJumpReq    = 0
	self.tLastGround = 0

end

-- Update
--
function Jump:update(dt)
	self.tJumpReq    = self.tJumpReq > 0 and self.tJumpReq - dt or 0
	self.tLastGround = self.tLastGround + dt
	self.isJumping   = self.jumpNum > 0
end

-- Event: onContact
--
function Jump:onContact(con)
	if con.norm.y == -1 then
		self.jumpNum     = _.__max(0, self.jumpNum - 1)
		self.tLastGround = 0
	end
end

-- Event: onJump
--
function Jump:onJump()
	self.tJumpReq = 0  -- reset
	self.jumpNum  = self.jumpNum + 1
	self.jumpTerm = false
end

-- Event: offJump
--
function Jump:offJump()
	--
end

-- Request jump.
--
function Jump:onRqJump()
	self.tJumpReq = self.jumpForgive
end

-- Request fall.
--
function Jump:offRqJump()
	self.jumpTerm = true
end

return Jump