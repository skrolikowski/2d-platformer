-- Player Entity
--

local Base   = require 'src.entities.entity'
local Player = Base:extend(
	Components['contact'](),
	Components['crouch'](),
	Components['jump'](),
	Components['gravity'](),
	Components['axis'](500, 300),
	Components['state'](),
	Components['animation']()
)

-- New Player Unit
--
function Player:new(data)
	Base.new(self, _:merge(data, {
		name     = 'player',
		bodyType = 'kinematic'
	}))

	-- register
	Gamestate.current():registerControls({
		onCrouch  = function(...) self:onRequestCrouch(...)  end,
		offCrouch = function(...) self:offRequestCrouch(...) end,
		onJump    = function(...) self:onRequestJump(...)    end,
		offJump   = function(...) self:offRequestJump(...)   end,
		axis      = function(...) self:onAxisChange(...)     end,
	})
end

-- Teardown
--
function Player:destroy()
    Gamestate.current():unregisterControls({
    	'onCrouch',
    	'offCrouch',
    	'onJump',
    	'offJump',
    	'axis'
    })
    --
    Base.destroy(self)
end

-- Draw (debug)
--
function Player:draw()
	local cx, cy  = self:center()
	local r, g, b = unpack(Config.color.debug)

	lg.setColor(r, g, b, 0.5)
	lg.setLineWidth(1)

	lg.circle('line', cx, cy, 3)
	lg.rectangle('line', self:container())
end

return Player