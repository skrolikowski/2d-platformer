--
--
Util = {}

-- vendor
pprint = require 'vendor.pprint.pprint'

-- Math
AABB    = require 'src.toolbox.math.aabb'
Vec2    = require 'src.toolbox.math.vec2'
Segment = require 'src.toolbox.math.segment'

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