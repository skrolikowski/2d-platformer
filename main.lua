-- 2D Platformer
-- https://github.com/skrolikowski/2d-platformer
--
la = love.audio
lf = love.filesystem
lm = love.mouse
lx = love.math
lg = love.graphics
lj = love.joystick

-- pixels please..
-- lg.setDefaultFilter('nearest', 'nearest')

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


local background, foreground

-- load
--
function love.load()
    _Keys    = {}
    _Buttons = {}

    --
    Gamestate.registerEvents()
    Gamestate.switch(Gamestates['scene'], {
        map = 'res/maps/AA.lua',
        row = 46,
        col = 20
    })
end

-- Update
--
function love.update(dt)
    --
    -- Controls:
    -- Key Down
    for code, time in pairs(_Keys) do
        _Keys[code] = time + dt

        _:dispatch('keyDown_' .. code, dt, _Keys[code])
    end

    -- Controls:
    -- Button Down
    for code, time in pairs(_Buttons) do
        _Buttons[code] = time + dt

        _:dispatch('btnDown_' .. code, dt, _Buttons[code])
    end
end

---- ---- ---- ----

-- Controls:
-- Key Pressed
--
function love.keypressed(key)
    _:dispatch('keyOn_' .. key)

    _Keys[key] = 0
end

-- Controls:
-- Key Released
--
function love.keyreleased(key)
    _:dispatch('keyOff_' .. key)
    _Keys[key] = nil
end

-- Controls:
-- Mouse button pressed
--
function love.mousepressed(x, y, button)
    _:dispatch('btnOn_' .. button)
    _Buttons[button] = 0
end

-- Controls:
-- Mouse button released
--
function love.mousereleased(x, y, button)
    _:dispatch('btnOff_' .. button)
    _Buttons[button] = nil
end

-- Controls:
-- Mouse moved
--
function love.mousemoved()
    _:dispatch('mouseMove')
end

-- -- Controls - Button Pressed
-- function love.gamepadaxis(joystick, axis, value)
-- 	print('gamepadaxis', joystick, axis, value)
-- 	--
-- 	-- triggers
-- 	-- if axis == 'triggerleft'  and value == 1 then  end
-- 	-- if axis == 'triggerleft'  and value == 0 then  end
-- 	-- if axis == 'triggerright' and value == 1 then  end
-- 	-- if axis == 'triggerright' and value == 0 then  end
-- end

-- -- Controls - Button Pressed
-- function love.gamepadpressed(joystick, button)
-- 	print('gamepadpressed', joystick, button)
-- 	_Buttons[button] = 0
-- 	player:onButtonPressed(button)
-- end

-- -- Controls - Button Released
-- function love.gamepadreleased(joystick, button)
--     print('gamepadreleased', joystick, button)
--     _Buttons[button] = nil
--     player:onButtonReleased(button)
-- end