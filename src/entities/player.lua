-- Player Entity
--

local Contact  = Components['contact']()
local Jump     = Components['jump'](Config.world.tileSize * 6, 0.4)
local Gravity  = Components['gravity'](Config.world.tileSize * 6, 0.4)
local Movement = Components['movement'](500, 300)

local Base   = require 'src.entities.entity'
local Player = Base:extend(Contact, Jump, Gravity, Movement)

-- New Player Unit
--
function Player:new(data)
	Base.new(self, _:merge(data, {
		name     = 'player',
		bodyType = 'kinematic'
	}))

	-- register
	Gamestate.current():registerControls({
		onJump  = function(...) self:onRequestJump(...)  end,
		offJump = function(...) self:offRequestJump(...) end,
		axis    = function(...) self:onAxisChange(...)   end,
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