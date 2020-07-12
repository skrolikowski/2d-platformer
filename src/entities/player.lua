-- Player Entity
--

local Contact  = Components['contact']()
local Crouch   = Components['crouch']()
local Jump     = Components['jump']()
local Gravity  = Components['gravity']()
local Axis     = Components['axis'](500, 300)
local State    = Components['state']()

local Base   = require 'src.entities.entity'
local Player = Base:extend(Contact, Crouch, Jump, Gravity, Axis, State)

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
    Gamestate.current():unregisterControls({ 'onJump', 'offJump', 'axis' })
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