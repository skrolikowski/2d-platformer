-- Defense System
--

local Base    = require 'src.entities.systems.base'
local Defense = Base:extend()

-- New
--
function Defense:new(host, data)
	Base.new(self, host, { 'defense' })
end

-- Draw
--
function Defense:draw()
	-- local x, y, w, h = self.host:container()
	-- local r, g, b    = unpack(self.color)
	-- local hpPct      = self.host:hpPct()

	-- lg.setColor(0,0,0,1)
	-- lg.setLineWidth(1)
	-- lg.rectangle('line', -w/2, h/2+4, w, 2)

	-- lg.setColor(r,g,b,1)
	-- lg.rectangle('fill', -w/2, h/2+4, w * hpPct, 2)
end

return Defense