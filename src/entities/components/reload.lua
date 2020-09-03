-- Reload Component
--

local Base   = require 'modern'
local Reload = Base:extend()

-- New
--
function Reload:new(host, data)
	self.host = host

	--
	-- flags
	self.isReloading = false
	self.isReqReload = false
end

-- Event: onReload
--
function Reload:onReload()
	self.isReloading = true
	self.isReqReload = false
end

-- Event: offReload
--
function Reload:offReload()
	self.isReloading = false
	self.isReqReload = false
end

-- Event: onReqReload
--
function Reload:onRqReload()
	self.isReqReload = true
end

-- Event: offReqReload
--
function Reload:offRqReload()
	self.isReqReload = false
end

-- Event: onAnimationComplete
--
function Reload:onAnimationComplete(name)
	if name == 'reload' then
		self:offReload()
	end
end

return Reload