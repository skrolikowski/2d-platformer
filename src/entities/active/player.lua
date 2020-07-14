-- Player Entity
--

local Base   = require 'src.entities.active.active'
local Player = Base:extend(
	Components['contact'](),
	Components['move'](),
	Components['crouch'](),
	Components['roll'](),
	Components['jump'](),
	Components['gravity'](),
	Components['state'](),
	Components['animation']()
)

-- New Player Unit
--
function Player:new(data)
	Base.new(self, _:merge(data, {
		name = 'player',
	}))
	--
	-- register
	Gamestate.current():registerControls({
		onCrouch  = function(...) self:onRequestCrouch(...)  end,
		offCrouch = function(...) self:offRequestCrouch(...) end,
		onJump    = function(...) self:onRequestJump(...)    end,
		offJump   = function(...) self:offRequestJump(...)   end,
		axis      = function(...) self:onRequestAxis(...)    end,
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

function Player:update(dt)
	Base.update(self, dt)
end

function Player:draw()
	Base.draw(self)
end

return Player