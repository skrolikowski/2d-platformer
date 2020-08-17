-- Base Unit Entity
--

local Base = require 'src.entities.entities.entity'
local Unit = Base:extend()

-- New
--
function Unit:new(data)
	Base.new(self, _:merge({
		mixins = {
			transform = {
				x = data.x,
				y = data.y,
				w = data.w or 16,
				h = data.h or 32,
			}
		}
	}, data))

	--
	-- properties
	self._state = data.state or 'idle'
	self.sm     = SM(self, data.systems   or {})
	self.bm     = BM(self, data.behaviors or {})
end

-- Destroy
--
function Unit:destroy()
	self.sm:destroy()
	--
	Base.destroy(self)
end

-- Dispatch event
--
function Unit:dispatch(event, ...)
	Base.dispatch(self, event, ...)
	--
	self.sm:dispatch(event, ...)
	self.bm:dispatch(event, ...)
end

-- Update
--
function Unit:update(dt)
	local vx, vy = self:vel():unpack()

	--
	-- Is Reviving
	if self.isReviving then
		self:state('revive')
	--
	-- Is Dead
	elseif self.isDead then
		self:state('die')
	--
	-- Is Taking Damage
	elseif self.isTakingDamage then
		self:state('hit')
	--
	-- Is Grounded
	elseif self.isOnGround then
		if     self.isRolling   then self:state('roll')
		elseif self.isAttacking then self:state('attack')
		elseif self.isCrouching then self:state('crouch')
		elseif self.isDashing   then self:state('dash')
		elseif _.__abs(vx) > 1  then self:state('walk')
		else                         self:state('idle')
		end
	else
	--
	-- In-Air
		if     self.isAttacking then self:state('attack')
		elseif vy < 0           then self:state('jump')
		else                         self:state('fall')
		end
	end

	self.sm:update(dt)
	self.bm:update(dt)
	--
	Base.update(self, dt)
end

function Unit:draw()
	local cx, cy  = self:center()
	local sx, sy  = self._sx, self._sy

	lg.push()
	lg.translate(cx, cy)
	lg.scale(sx, sy)

	self.sm:draw()
	
	lg.pop()
end

-- Get/set `state` value.
--
function Unit:state(value)
	if value == nil then
		return self._state
	end

	if self._state ~= value then
		self._state = value
	end
end

-- Does unit have system with `name`?
--
function Unit:hasSystem(name)
	return self.sm:has(name)
end

-- Add systems to unit
--
function Unit:addSystems(systems)
	return self.sm:add(systems)
end

return Unit