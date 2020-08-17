-- Roll Component
--

local Base = require 'modern'
local Roll = Base:extend()

-- New
--
function Roll:new(host, data)
	--
	self.host = host
	
	-- properties
	self.rollSpeedScale = 1.25
	self.rollForgive    = 0.15

	-- flags
	self.isRolling = false

	-- timers
	self.tRollReq = 0
end

-- Update
--
function Roll:update(dt)
	self.tRollReq = self.tRollReq > 0 and self.tRollReq - dt or 0
end

---- ---- ---- ----

-- Request roll.
--
function Roll:onRqRoll()
	self.tRollReq = self.rollForgive
end

-- Event: onRoll
--
function Roll:onRoll()
	self.isRolling = true
	self.tRollReq  = 0 -- reset
end

-- Event: offRoll
--
function Roll:offRoll()
	self.isRolling = false
end

return Roll