-- Source Component
--

local Base   = require 'modern'
local Source = Base:extend()

-- New
--
function Source:new(host, data)
	self.host = host

	--
	-- properties
	self._src = data.src or host
end

-- Get/set `source` value
--
function Source:source(value)
	if value == nil then
		return self._src
	end

	self._src = value
end

return Source