-- Lock Component
--

local Base = require 'modern'
local Lock = Base:extend()

-- New
--
function Lock:new(host, data)
	self.host = host
	
	--
	-- flags
	self.isLocked = false
end

---- ---- ---- ----

-- Request locked
--
function Lock:onLock()
	self.isLocked = true
end

-- Request unlocked
--
function Lock:offLock()
	self.isLocked = false
end

return Lock