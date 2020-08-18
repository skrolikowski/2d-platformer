-- Stamina System
--

local Base    = require 'src.entities.systems.base'
local Stamina = Base:extend()

-- New
--
function Stamina:new(host, data)
	Base.new(self, host, { 'transform', 'stamina' })
	
	--
	-- properties
	self.color = { _:color('green-500') }
	
	-- set component values..
	host:sp(data.sp or host._sp)
	host:spMax(data.sp or host._spMax)
end

-- Draw
--
function Stamina:draw()
	local x, y, w, h = self.host:container()
	local r, g, b    = unpack(self.color)
	local spPct      = self.host:spPct()

	lg.setColor(0,0,0,1)
	lg.setLineWidth(1)
	lg.rectangle('line', -w/2, h/2+6, w, 2)

	lg.setColor(r,g,b,1)
	lg.rectangle('fill', -w/2, h/2+6, w * spPct, 2)
end

return Stamina