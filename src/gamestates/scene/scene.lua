-- Scene - Gameplay
--

local Base  = require 'src.gamestates.gamestate'
local Scene = Base:extend()

-- Event: onLoad
--
function Scene:init(data)
	Base.init(self, _:merge(data, {}))
	--
end

-- Tear down
--
function Scene:destroy()
	self:unbindControls({
		'onAxis',
		'onAttack',
		'onCrouch',
		'offCrouch',
		'onJump',
		'offJump',
	})
	--
	self.camera:destroy()
	self.world:destroy()
end

---- ---- ---- ----

-- Event: onEnter
--
function Scene:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- bootstrap
	self:loadMap()

	self.world = World(self)
	self.world:addLayer(self.map.layers['Bounds'])
	-- self.world:addLayer(self.map.layers['Slopes'])
	
	--
	-- spawn player
	self.player = Entities['kinematic']('player',
		{
			x      = self.settings['col'] * Config.world.tileSize,
			y      = self.settings['row'] * Config.world.tileSize,
			width  = 16,
			height = 32
		},
		-- Components['detection'](),
		Components['contact'](),
		Components['attack'](),
		Components['crouch'](),
		Components['roll'](),
		Components['move'](),
		Components['jump'](),
		Components['gravity'](),
		Components['state'](),
		Components['animation']()
	)
	-- self.player:behavior():set('attack','patrol')
	self.world:add(self.player)

	--
	-- camera
	-- self.focus  = self.player
	self.camera = Camera(
		Config.world.tileSize * (self.settings['col'] or 0),
		Config.world.tileSize * (self.settings['row'] or 0),
		Config.camera.scale or 1
	)

	-- controls
	self:registerControls('scene')
	self:bindControls({
		onAxis    = function(...) self.player:onRequestAxis(...)    end,
		onAttack  = function(...) self.player:onRequestAttack(...)  end,
		onCrouch  = function(...) self.player:onRequestCrouch(...)  end,
		offCrouch = function(...) self.player:offRequestCrouch(...) end,
		onJump    = function(...) self.player:onRequestJump(...)    end,
		offJump   = function(...) self.player:offRequestJump(...)   end,
	})

	-- flags
	self.isPaused = false
end

-- Event: onResume
--
function Scene:resume()

end

-- Event: onLeave
--
function Scene:leave()
	self:destroy()
end

---- ---- ---- ----

-- Update
--
function Scene:update(dt)
	self.camera:lookAt(self.player:center())

	--
	self.world:queryWorld(function(item)
		if item._bodyType == 'kinematic' then
			item:update(dt)
		end
	end)
	--
    Base.update(self, dt)
end

-- Draw
--
function Scene:draw()
    self.camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

		self.world:queryScreen(function(item)
			item:draw()
		end)

		lg.setColor(Config.color.white)
        lg.draw(self.foreground)
    end)
    --
    Base.draw(self)
end

---- ---- ---- ----

function Scene:loadMap()
	--
	local STI = require 'vendor.sti.sti'

	self.map    = STI(self.settings['map'])
	self.width  = self.map.width  * self.map.tilewidth
	self.height = self.map.height * self.map.tileheight

	--
	self.background = lg.newCanvas(self.width, self.height)
    lg.setCanvas(self.background)
	    self.map:drawTileLayer('Background')
	    self.map:drawTileLayer('Decoratives (B1)')
	    self.map:drawTileLayer('Decoratives (B2)')
	    self.map:drawTileLayer('Decoratives (B3)')
	    self.map:drawTileLayer('Platform')
    lg.setCanvas()

    --
    self.foreground = lg.newCanvas(self.width, self.height)
    lg.setCanvas(self.foreground)
    	self.map:drawTileLayer('Decoratives (F1)')
	    self.map:drawTileLayer('Decoratives (F2)')
    lg.setCanvas()
end

return Scene