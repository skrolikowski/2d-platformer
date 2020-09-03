-- Animation System
--

local Base      = require 'src.entities.systems.base'
local Animation = Base:extend()

-- New
--
function Animation:new(host, data)
	Base.new(self, host, { 'axis' })

	--
	-- properties
	self.sprite = Sprite[host.name]

	-- set up post-callback
	self.sprite:each(function(anim, name)
		anim:after(function()
			host:dispatch('onAnimationComplete', name)
		end)
	end)
end

-- Event: onStateChange
--
function Animation:onStateChange(state)
	self.sprite:set(state)
end

-- Update
--
function Animation:update(dt)
	self.sprite:update(dt)
end

-- Draw
--
function Animation:draw()
	lg.push()
	lg.scale(
		self.host:sx() * self.host:facing(),
		self.host:sy())
	--
	self.sprite:draw()
	--
	lg.pop()
end

return Animation