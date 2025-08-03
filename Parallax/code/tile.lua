local tile = {}
tile.__index = tile

local function new(float, player)
    local mt = {
        float = float or false,
        player = player or -1
    }

    return setmetatable(mt, tile)
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })