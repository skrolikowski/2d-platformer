-- Debug System
--

local Base  = require 'src.entities.systems.base'
local Debug = Base:extend()

-- New
--
function Debug:new(host, data)
	Base.new(self, host, { 'transform' })
	--

	-- properties
	self.color = data.color or { _:color('red-300') }
	self.text  = lg.newText(Config.ui.font.xs, host:state())
end

-- Draw
--
function Debug:draw()
	local w, h    = self.host:dimensions()
	local r, g, b = unpack(self.color)

	--
	-- aabb
	lg.setColor(r, g, b, 0.5)
	lg.setLineWidth(1)

	lg.circle('line', 0, 0, 3)
	lg.rectangle('line', -w/2, -h/2, w, h)

	--
	-- state
	lg.setColor(1, 1, 1, 1)
	lg.setFont(Config.ui.font.xs)

	lg.printf(self.host:state(), -w, -h/2-8, w*2, 'center')
end

return Debug