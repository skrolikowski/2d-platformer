-- Expire System
--

local Base   = require 'src.entities.systems.base'
local Expire = Base:extend()

-- New
--
function Expire:new(host, data)
	Base.new(self, host, { })

	--
	Timer.after(data.delay or 5, function()
		self.host:destroy()
	end)
end

return Expire