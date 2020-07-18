--
--
Util = {}

-- vendor
pprint = require 'vendor.pprint.pprint'

-- math
AABB    = require 'src.toolbox.math.aabb'
Vec2    = require 'src.toolbox.math.vec2'
Segment = require 'src.toolbox.math.segment'

-- graphics
Animator    = require 'src.toolbox.graphics.animator'
Spritesheet = require 'src.toolbox.graphics.spritesheet'

-- quick lua implementation of "random" UUID
-- https://gist.github.com/jrus/3197011
--
function Util:uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return _.__gsub(template, '[xy]', function (c)
        local v = (c == 'x') and _.__random(0, 0xf) or _.__random(8, 0xb)
        return _.__format('%x', v)
    end)
end

function Util:sign(value)
    if     value > 0 then return  1
    elseif value < 0 then return -1
    end

    return 0
end

-- Create boolean hash table for convenience
--
function Util:toBoolean(value)
	local t = {}

	for __, v in pairs(value) do
		t[v] = true
	end

	return t
end