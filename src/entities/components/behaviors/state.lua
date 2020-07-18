-- State Behavioral Component
--

local Base  = require 'src.entities.components.component'
local State = Base:extend()

-- New..
--
function State:new(state)
	--
	-- properties
	self._state = {
		curr = state or 'idle',
		text = lg.newText(Config.ui.font.xs, state or 'idle')
	}
end

-- Update
--
function State:update(dt)
	--
	-- Ground Actions
	if self.host:onGround() then
		if self.host._isRolling then
			self.host:onSetState('roll')
		elseif self.host._isAttacking then
			self.host:onSetState('attack')
		elseif self.host._isCrouching then
			self.host:onSetState('crouch')
		elseif _.__abs(self.host:vx()) > 1 then
			self.host:onSetState('walk')
		else
			self.host:onSetState('idle')
		end
	--
	-- In-air Actions
	else
		if self.host._isAttacking then
			self.host:onSetState('attack')
		elseif self.host:vy() < 0 then
			self.host:onSetState('jump')
		else
			self.host:onSetState('fall')
		end
	end
end

-- Draw
--
function State:draw()
    local cx, cy = self.host:center()
	local w, h   = self._state.text:getDimensions()
	local sx, sy = self.host:sx(), self.host:sy()
	local ox, oy = 0, Config.world.tileSize * 1.5

	lg.setColor(Config.color.white)
	lg.setFont(self._state.text:getFont())

	lg.draw(self._state.text, cx-w/2, cy, 0, sx, sy, ox, oy)
end

---- ---- ---- ----

function State:onSetState(state)
	if state ~= self._state.curr then
		self._state.curr = state
		self._state.text:set(state)
	end
end

return State