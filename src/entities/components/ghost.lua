-- Ghost Component
--

local Base  = require 'modern'
local Ghost = Base:extend()

-- New
--
function Ghost:new(host, data)
	self.host = host
end

return Ghost