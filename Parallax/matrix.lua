local Matrix = {}
Matrix.__index = Matrix

function Matrix.Create()
    local self = setmetatable({}, Matrix)

    return self
end

function Matrix:get(i, j)
    self[i] = self[i] or {}

    return self[i][j]
end

function Matrix:set(i, j, value)
    self[i] = self[i] or {}
    self[i][j] = value
end

return Matrix
