-- Spritesheet util
-- Shane Krolikowski
--

local __getIndex = function(obj, row, col)
    return ((col-1) + (row-1) * obj.cols) + 1
end

local Modern = require 'modern'
local Sheet  = Modern:extend()

-- New
--
function Sheet:new(path)
    self.image = path and lg.newImage(path) or nil
    self.quads = {}
end

-- Load image path
-- [Chain]
--
function Sheet:load(path)
    self.image = lg.newImage(path)
    return self
end

-- Split by width/height
-- [Chain]
--
function Sheet:split(width, height)
    self.width  = width
    self.height = height
    self.rows   = _.__ceil(self.image:getHeight() / height)
    self.cols   = _.__ceil(self.image:getWidth() / width)
    
    --
    for r = 1, self.rows do
        for c = 1, self.cols do
            local w = self.width
            local h = self.height
            local x = (c-1) * w
            local y = (r-1) * h

            table.insert(self.quads,
                lg.newQuad(x, y, w, h, self.image:getDimensions()))
        end
    end

    return self
end

-- Query quad by row x col.
--
function Sheet:query(row, col)
    local index = __getIndex(self, row, col)

    return self.quads[index]
end

return Sheet