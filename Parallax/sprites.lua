local Gif = require 'gif'

local sprites = {}

sprites[1] = 'Base.png'
sprites[2] = 'Hover.png'
sprites[3] = 'Float.png'
sprites[4] = 'Cross.png'
sprites[5] = 'Dot.png'
sprites[6] = 'Base2.png'
sprites[7] = 'CardBase.png'
sprites[8] = 'CardFlip.png'
sprites[9] = 'CardRow.png'
sprites[10] = 'CardColumn.png'

for i = 1, #sprites do
    sprites[i] = love.graphics.newImage('sprites/'..sprites[i])
    sprites[i]:setFilter('nearest', 'nearest')
end

sprites[1] = love.graphics.newImage('sprites/Base-Sheet.png')
sprites[1]:setFilter('nearest', 'nearest')
sprites[1] = Gif.Create(sprites[1], 4)

return sprites
