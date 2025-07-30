---@class Matrix
local Matrix = {}
Matrix.__index = Matrix

---@return Matrix
local function new()
    return setmetatable({}, Matrix)
end

---@param i number
---@param j number
---@param value nil
function Matrix:set(i, j, value)
    self[i] = self[i] or {}
    self[i][j] = value
end

---@param i number
---@param j number
---@return nil
function Matrix:get(i, j)
    if self[i] ~= nil then
        return self[i][j]
    end
    return nil
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})