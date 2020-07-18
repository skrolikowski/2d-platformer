-- Base Component
--

local Base      = require 'modern'
local Component = Base:extend()

function Component:__new(data)
	self.host = self.__module
end

return Component