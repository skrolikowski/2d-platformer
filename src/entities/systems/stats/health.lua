-- Health System
--

local Base   = require 'src.entities.systems.base'
local Health = Base:extend()

-- New
--
function Health:new(host, data)
	Base.new(self, host, { 'transform', 'health' })
	
	--
	-- properties
	self.color = { _:color('red-500') }
	
	-- set component values..
	host:hp(data.hp or host._hp)
	host:hpMax(data.hp or host._hpMax)
end

-- Event: onBuff
--
function Health:onBuff(item)
	if item.stat == 'health' then
		self.host:increaseHp(item.value)
	end
end

-- Event: onDebuff
--
function Health:onDebuff(item)
	if item.stat == 'health' then
		self.host:decreaseHp(item.value)
	end
end

-- Draw
--
function Health:draw()
	local x, y, w, h = self.host:container()
	local r, g, b    = unpack(self.color)
	local hpPct      = self.host:hpPct()

	lg.setColor(0,0,0,1)
	lg.setLineWidth(1)
	lg.rectangle('line', -w/2, h/2+4, w, 2)

	lg.setColor(r,g,b,1)
	lg.rectangle('fill', -w/2, h/2+4, w * hpPct, 2)
end

return Health