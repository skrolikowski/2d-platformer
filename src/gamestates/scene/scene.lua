-- Scene - Gameplay
--
local Base  = require 'src.gamestates.gamestate'
local Scene = Base:extend()

local dispatch = function(obj, name, ...)
	return obj:dispatch(name, ...)
end

-- Event: onLoad
--
function Scene:init(data)
	Base.init(self, {
		name     = 'scene',
		controls = _Control['scene']
	})
end

-- Tear down
--
function Scene:destroy()
	Base.destroy(self)
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
	self.focus = new(Entity['player'], {
		x = 2  * Config.world.tileSize,
		y = 28 * Config.world.tileSize,
	})

	--[[
		-- Enemies
		-- ----
		-- Skeleton
		new(Entity['skeleton'], {
			x = 10 * Config.world.tileSize,
			y = 28 * Config.world.tileSize,
		})
	]]--

	--
	-- camera
	self.camera = Camera(
		Config.world.tileSize * (self.settings['col'] or 0),
		Config.world.tileSize * (self.settings['row'] or 0),
		Config.camera.scale or 1
	)

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

-- Event: on request
--
function Scene:on(name, ...)
	if self.focus then
		self.focus:dispatch('onRq' .. _:upperFirst(name), ...)
	end
end

-- Event: off request
--
function Scene:off(name, ...)
	if self.focus then
		self.focus:dispatch('offRq' .. _:upperFirst(name), ...)
	end
end

---- ---- ---- ----

-- Update
--
function Scene:update(dt)
	--
	-- camera focus
	self.camera:lookAt(
		self.focus:center())

	-- update entities
	self.world:queryWorld(function(item)
		item:update(dt)
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

        -- draw entities
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
	    -- self.map:drawTileLayer('Background')
	    -- self.map:drawTileLayer('Decoratives (B1)')
	    -- self.map:drawTileLayer('Decoratives (B2)')
	    -- self.map:drawTileLayer('Decoratives (B3)')
	    self.map:drawTileLayer('Platform')
    lg.setCanvas()

    --
    self.foreground = lg.newCanvas(self.width, self.height)
    lg.setCanvas(self.foreground)
    	-- self.map:drawTileLayer('Decoratives (F1)')
	    -- self.map:drawTileLayer('Decoratives (F2)')
    lg.setCanvas()
end

return Scene