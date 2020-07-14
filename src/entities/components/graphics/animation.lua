-- Animation Component
--

local Base      = require 'src.entities.components.component'
local Animation = Base:extend()

-- New..
--
function Animation:new()
	--
	-- properties
	self._sprite_ox = 0
	self._sprite_oy = 2

	-- flags
	self._isMirrored = false
	self._isFlipped  = false
end

-- Setup..
--
function Animation:__new(data)
	Base.__new(self, data)
	--
	-- properties
	self._sheet      = Config.world.entity[self.host.name].sheet
	self._animations = Config.world.entity[self.host.name].animation
	self._sprite     = Animator()

	-- add animations
    for name, animation in pairs(self._animations) do
    	--
    	-- setup callback
    	animation.after = function()
    		self:onAnimationComplete()
    	end

    	-- add animation
		self._sprite:addAnimation(name, _:merge({ image = self._sheet }, animation))
	end

	--
	self._sprite:switchTo('idle')
end

-- Update
--
function Animation:update(dt)
	if self.host.ax and self.host:ax() ~= 0 then
		self._isMirrored = self.host:ax() < 0
	end
	
	self._sprite:update(dt)
end

-- Draw
--
function Animation:draw()
	local cx, cy = self.host:center()
	local w, h   = self._sprite:dimensions()
	local sx, sy, ox, oy
    
    --
	-- scale/flip
    sx = self.host:sx()
    sy = self.host:sy()

    if self:isMirrored() then sx = -sx end
    if self:isFlipped()  then sy = -sy end

    -- offset
    ox = self._sprite_ox + w / 2
    oy = self._sprite_oy + h / 2

    -- draw
    lg.setColor(Config.color.white)

    self._sprite:draw(cx, cy, 0, sx, sy, ox, oy)
end

---- ---- ---- ----

-- Event: onAnimationComplete
--
function Animation:onAnimationComplete()
	local funcName = 'on' ..
	                 _:upperFirst(self._sprite.current.name) ..
	                 'AnimationComplete'

	if self.host[funcName] then
		self.host[funcName](self.host)
	end
end

-- Event: onSetState
-- Set new animation state.
--
function Animation:onSetState(name)
	if self._sprite.current.name ~= name then
		self._sprite:switchTo(name)
	end
end

---- ---- ---- ----

-- Flag check
--

-- Get/set `_isMirrored` flag
function Animation:isMirrored(value)
	if value == nil then
		return self._isMirrored
	end

	self._isMirrored = value
end

-- Get/set `_isFlipped` flag
function Animation:isFlipped(value)
	if value == nil then
		return self._isFlipped
	end

	self._isFlipped = value
end

return Animation