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

--[[
local p1, p2, grid, ray, marks

function love.load()
    p1    = Vec2()
    p2    = Vec2(lm.getPosition())
    marks = {}
    grid  = Grid({
        width = lg.getWidth(),
        height = lg.getHeight()
    }, 64)
end

function love.update(dt)
    grid:reset()
    marks = {}
    ray   = p2 - p1

    --
    local cells = grid:queryCellsOnSegment(p1.x, p1.y, p2.x, p2.y)

    for __, cell in pairs(cells) do
        cell.items['--'] = { '--' }
    end
end

function love.draw()
    grid:draw()

    lg.setColor(1,0,0,1)
    lg.line(p1.x, p1.y, p2.x, p2.y)

    for __, mark in pairs(marks) do
        lg.circle('line', mark.x, mark.y, 3)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(x, y)
    p1 = Vec2(x, y)
end

function love.mousemoved(x, y)
    p2 = Vec2(x, y)
end
]]--

-- load
--
function love.load()
    _Keys    = {}
    _Buttons = {}

    --
    Gamestate.registerEvents()
    Gamestate.switch(Gamestates['scene'], {
        map = 'res/maps/Cemetary/001.lua',
        row = 26,
        col = 5
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

--[[
-- Controls - Button Pressed
function love.gamepadaxis(joystick, axis, value)
	print('gamepadaxis', joystick, axis, value)
	--
	-- triggers
	-- if axis == 'triggerleft'  and value == 1 then  end
	-- if axis == 'triggerleft'  and value == 0 then  end
	-- if axis == 'triggerright' and value == 1 then  end
	-- if axis == 'triggerright' and value == 0 then  end
end

-- Controls - Button Pressed
function love.gamepadpressed(joystick, button)
	print('gamepadpressed', joystick, button)
	_Buttons[button] = 0
	player:onButtonPressed(button)
end

-- Controls - Button Released
function love.gamepadreleased(joystick, button)
    print('gamepadreleased', joystick, button)
    _Buttons[button] = nil
    player:onButtonReleased(button)
end
]]--