-- Death Behavior
--

local Base  = require 'src.entities.behaviors.base'
local Death = Base:extend()

-- New
--
function Death:new(manager, data)
	local systems = { 'death' }

	-- Is reviveable?
	if data.revive then
		systems['revive'] = data
	end

	--
	Base.new(self, 'death', manager, systems)
end

-- Pass
--
function Death:pass()
	return self.host.isDead
end

-- Execute behavior
--
function Death:execute(dt)
	return true
end

return Death