-- Follow System
--

local Base   = require 'src.entities.systems.base'
local Follow = Base:extend()

-- New
--
function Follow:new(host, data)
	Base.new(self, host, { 'source' })

	--
	-- properties
	self.offset = host:pos() - host:source():pos()
end

-- Update
--
function Follow:update(dt)
	local cx, cy = self.host:source():center()
	local ox, oy = self.offset:unpack()

	self.host.world:update(self.host, {
		x = cx + ox,
		y = cy + oy
	})
end

return Follow