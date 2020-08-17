package.path = package.path .. ";vendor/?.lua;vendor/?/init.lua"
require 'lua-lander'
--

function new(name, ...)
    local path = LUA_PATH and LUA_PATH or os.getenv "LUA_PATH" or "./?.lua"
    local name = _.__gsub(name, "%p+", "/")

    for path in string.gfind(path, '[^;]+') do
        path = _.__gsub(path, '?', name)

        if loadfile(path) then
            return dofile(path)(...)
        end
    end
    
    error('No such module exists: ' .. name)
end

function love.conf(t)
    io.stdout:setvbuf('no')

    t.identity = '2d-platformer'
    t.version  = '11.2'
    t.console  = false

    t.window.title      = '2d-platformer'
    t.window.x          = 100
    t.window.y          = 50
    t.window.width      = 1200
    t.window.height     = 800
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end