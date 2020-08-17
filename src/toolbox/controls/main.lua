Controls = require 'controls'
Timer    = require 'hump.timer'
pprint   = require 'pprint.pprint'
--
lt = love.timer

function love.load()
	cc = Controls({
		duck = { 'D' },
		roll = { 'D+J' },
		jump = { 'J' },
	})
end

function love.update(dt)
	cc:update(dt)
end

---- ---- ---- ----

-- Key Pressed
--
function love.keypressed(key)
	cc:onPressed(key)
end

-- Key Released
--
function love.keyreleased(key)
	cc:onReleased(key)
end