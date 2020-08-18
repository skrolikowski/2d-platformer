-- Guard Component
--

local Base  = require 'modern'
local Guard = Base:extend()

-- New
--
function Guard:new(host, data)
	self.host = host
	
	--
	-- flags
	self.isGuarding = false
end

---- ---- ---- ----

-- Request guard
--
function Guard:onRqGuard()
	self.isGuarding = true
end

-- Request unguard
--
function Guard:offRqGuard()
	self.isGuarding = false
end

return Guard