-- Mana System
--

local Base = require 'src.entities.systems.base'
local Mana = Base:extend()

-- New
--
function Mana:new(host, data)
	Base.new(self, host, { 'transform', 'mana' })
	
	--
	-- properties
	self.color = { _:color('blue-500') }
	
	-- set component values..
	host:mp(data.mp or host._mp)
	host:mpMax(data.mp or host._mpMax)
end

-- Draw
--
function Mana:draw()
	local x, y, w, h = self.host:container()
	local r, g, b    = unpack(self.color)
	local mpPct      = self.host:mpPct()

	lg.setColor(0,0,0,1)
	lg.setLineWidth(1)
	lg.rectangle('line', -w/2, h/2+6, w, 2)

	lg.setColor(r,g,b,1)
	lg.rectangle('fill', -w/2, h/2+6, w * mpPct, 2)
end

return Mana