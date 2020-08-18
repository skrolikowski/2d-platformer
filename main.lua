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
    Gamestate.current():onPressed(_.__lower('key_'..key))
end

-- Controls:
-- Key Released
--
function love.keyreleased(key)
    Gamestate.current():onReleased(_.__lower('key_'..key))
end

-- Controls:
-- Button Pressed
--
function love.gamepadaxis(joystick, axis, value)
	-- print('gamepadaxis', joystick, axis, value)
	--
	-- analog sticks
	if axis == 'leftx' then
		Gamestate.current():onPressed('btn_al', { x = value })
	elseif axis == 'lefty' then
		Gamestate.current():onPressed('btn_al', { y = value })
	elseif axis == 'rightx' then
		Gamestate.current():onPressed('btn_ar', { x = value })
	elseif axis == 'righty' then
		Gamestate.current():onPressed('btn_ar', { y = value })
	--
	-- triggers
	elseif axis == 'triggerleft' and value == 1 then
		Gamestate.current():onPressed(_.__lower('btn_l2'))
	elseif axis == 'triggerleft' and value == 0 then
		Gamestate.current():onReleased(_.__lower('btn_l2'))
	elseif axis == 'triggerright' and value == 1 then
		Gamestate.current():onPressed(_.__lower('btn_r2'))
	elseif axis == 'triggerright' and value == 0 then
		Gamestate.current():onReleased(_.__lower('btn_r2'))
	end
end

-- Controls:
-- Button Pressed
--
function love.gamepadpressed(joystick, button)
	-- print('gamepadpressed', button)
	--
	if button == 'leftshoulder' then
		Gamestate.current():onPressed('btn_l1')
	elseif button == 'rightshoulder' then
		Gamestate.current():onPressed('btn_r1')
	else
		Gamestate.current():onPressed(_.__lower('btn_'..button))
	end
end

-- Controls:
-- Button Released
--
function love.gamepadreleased(joystick, button)
    -- print('gamepadreleased', button)
    -- 
    if button == 'leftshoulder' then
		Gamestate.current():onReleased('btn_l1')
	elseif button == 'rightshoulder' then
		Gamestate.current():onReleased('btn_r1')
	else
		Gamestate.current():onReleased(_.__lower('btn_'..button))
	end
end