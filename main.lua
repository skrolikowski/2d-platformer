-- 2D Platformer
-- https://github.com/skrolikowski/2d-platformer
--
la = love.audio
lf = love.filesystem
lm = love.mouse
lx = love.math
lg = love.graphics
lj = love.joystick
lt = love.timer

-- pixels please..
lg.setDefaultFilter('nearest', 'nearest')

-- load gamepad mappings
-- lj.loadGamepadMappings('vendor/gamecontrollerdb.txt')

-- vendor packages
pprint    = require 'vendor.pprint.pprint'
Camera    = require 'vendor.hump.camera'
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'

-- configurations
require 'src.config'
require 'src.control'

-- local packages
require 'src.gamestates'
require 'src.toolbox'
require 'src.entities'
require 'src.world'

-- load
--
function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Gamestates['scene'], {
        map = 'res/maps/Cemetary/001.lua',
        row = 28,
        col = 10
    })
end

-- Update
--
function love.update(dt)
    Timer.update(dt)
end

---- ---- ---- ----

-- Controls:
-- Key Pressed
--
function love.keypressed(key)
    Gamestate.current():onPressed(key)
end

-- Controls:
-- Key Released
--
function love.keyreleased(key)
    Gamestate.current():onReleased(key)
end