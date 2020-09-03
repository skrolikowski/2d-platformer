-- Sprite Component
--

local Base   = require 'modern'
local Sprite = Base:extend()

-- New
--
function Sprite:new(host, data)
	self.host = host

	--
	-- properties
	self.sprite = lg.newImage(data.path)
end

return Sprite