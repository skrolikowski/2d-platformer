--
--
Util = {}

-- vendor
pprint = require 'vendor.pprint.pprint'
JSON   = require 'vendor.json4lua.json'

-- Controls
Control = require 'src.toolbox.controls.control'

-- math
AABB    = require 'src.toolbox.math.aabb'
Dice    = require 'src.toolbox.math.dice'
Segment = require 'src.toolbox.math.segment'
Vec2    = require 'src.toolbox.math.vec2'

-- Animations
AnimSheet = require 'src.toolbox.animations.sheet'
Animation = require 'src.toolbox.animations.animation'
Animator  = require 'src.toolbox.animations.animator'
require 'src.toolbox.animations.config'

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

function Util:buildDir(path, tbl)
    tbl = tbl or {}

    for __, file in pairs(files) do
    end


    return tbl
end

function Util:buildDir(path, tbl)
    local files = lf.getDirectoryItems(path)
    local info, name

    tbl = tbl or {}

    for __, file in pairs(files) do
        if not _:startsWith(file, '[.]') then
            info = lf.getInfo(path .. '/' .. file)
            name = string.match(file, "([%a|%-_|%d]+)")

            if info.type == 'directory' then
                tbl = Util:buildDir(path .. '/' .. file, tbl)
            else
                tbl[name] = require(path .. '/' .. name)
            end
        end
    end

    return tbl
end