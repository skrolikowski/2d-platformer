-- Range System
--

local Base  = require 'src.entities.systems.base'
local Range = Base:extend()

-- New
--
function Range:new(host, data)
	Base.new(self, host, { 'range', 'axis' })
end

-- Update
--
function Range:update(dt)
	if self.host.isRanged then
		print(self.host:axis())
		--
	end
end

return Range