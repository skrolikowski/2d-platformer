-- Animation Component
--

local Base      = require 'modern'
local Animation = Base:extend()

-- New
--
function Animation:new(host, data)
	self.host = host

	-- properties
	local config = Config.world.entity[self.host.name]

	-- add animations
	self.sprite = Animator()

    for name, animation in pairs(config.animation) do
    	--
    	-- setup callback
    	animation.after = function()
	    	self.host:dispatch('onAnimationComplete', name)
    	end

    	-- add animation
		self.sprite:addAnimation(name,
			_:merge({
				image = config.sheet[animation.sheet]
			}, animation)
		)
	end

	--
	self.sprite:switchTo('idle')
end

return Animation