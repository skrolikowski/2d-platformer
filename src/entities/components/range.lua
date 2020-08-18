-- Range Component
--

local Base  = require 'modern'
local Range = Base:extend()

-- New
--
function Range:new(host, data)
	self.host = host
	
	--
	-- flags
	self.isRanged = false
end

-- Request range mode
--
function Range:onRqRange()
	self.isRanged = true
end

-- Request standard mode
--
function Range:offRqRange()
	self.isRanged = false
end

return Range