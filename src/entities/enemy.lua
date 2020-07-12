-- Enemy Entity
--

local Contact = Components['contact']()
local Gravity = Components['gravity']()
local Axis    = Components['axis']()

local Base  = require 'src.entities.entity'
local Enemy = Base:extend(Contact, Gravity, Axis)

-- New Enemy Unit
--
function Enemy:new(data)
	Base.new(self, _:merge(data, {
		name     = 'enemy',
		bodyType = 'kinematic'
	}))
	--

end

-- Draw (debug)
--
function Enemy:draw()
	local cx, cy  = self:center()
	local r, g, b = unpack(Config.color.debug)

	lg.setColor(r, g, b, 0.5)
	lg.setLineWidth(1)

	lg.circle('line', cx, cy, 3)
	lg.rectangle('line', self:container())
end

return Enemy