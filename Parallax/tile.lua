---@class Tile
local Tile = {}
Tile.__index = Tile

---@param visible boolean
---@param player number
---@return Tile
local function new(visible, player)
    local mt = {
        visible = visible or false,
        player = player or -1
    }

    return setmetatable(mt, Tile)
end

---@param image Drawable
---@param x number
---@param y number
---@param scale number
function Tile:draw(image, x, y, scale)
    if image ~= nil then
        love.graphics.draw(image, x, y)
    else
        love.graphics.rectangle('line', x, y, scale, scale)
    end
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})