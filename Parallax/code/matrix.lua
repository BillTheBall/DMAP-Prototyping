local matrix = {}
matrix.__index = matrix

local function new()
    return setmetatable({}, matrix)
end

function matrix:set(i, j, value)
    self[i] = self[i] or {}
    self[i][j] = value
end

function matrix:get(i, j)
    if self[i] ~= nil then
        return self[i][j]
    end
    return nil
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })