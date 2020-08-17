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
    -- _Keys    = {}
    -- _Buttons = {}
    --
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
    -- --
    -- -- Controls:
    -- -- Key Down
    -- for code, time in pairs(_Keys) do
    --     _Keys[code] = time + dt

    --     _:dispatch('keyDown_' .. code, dt, _Keys[code])
    -- end

    -- -- Controls:
    -- -- Button Down
    -- for code, time in pairs(_Buttons) do
    --     _Buttons[code] = time + dt

    --     _:dispatch('btnDown_' .. code, dt, _Buttons[code])
    -- end
end

---- ---- ---- ----

-- Controls:
-- Key Pressed
--
function love.keypressed(key)
    Gamestate.current():onPressed(key)
    -- _:dispatch('keyOn_' .. key)

    -- _Keys[key] = 0
end

-- Controls:
-- Key Released
--
function love.keyreleased(key)
    Gamestate.current():onReleased(key)
    -- _:dispatch('keyOff_' .. key)
    -- _Keys[key] = nil
end

-- -- Controls:
-- -- Mouse button pressed

-- function love.mousepressed(x, y, button)
--     _:dispatch('btnOn_' .. button)
--     _Buttons[button] = 0
-- end

-- Controls:
-- -- Mouse button released
-- --
-- function love.mousereleased(x, y, button)
--     _:dispatch('btnOff_' .. button)
--     _Buttons[button] = nil
-- end

-- -- Controls:
-- -- Mouse moved
-- --
-- function love.mousemoved()
--     _:dispatch('mouseMove')
-- end
