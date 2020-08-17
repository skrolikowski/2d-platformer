package.path = package.path .. ";../../../vendor/?.lua;../../../?.lua;vendor/?/init.lua"
require 'lua-lander'
--

function love.conf(t)
    io.stdout:setvbuf('no')

    t.version  = '11.2'
    t.console  = false

    t.window.title      = '2d-platformer'
    t.window.x          = 100
    t.window.y          = 50
    t.window.width      = 400
    t.window.height     = 400
end