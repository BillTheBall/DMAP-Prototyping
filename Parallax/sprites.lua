local sprites = {}

sprites[1] = 'Base.png'
sprites[2] = 'Hover.png'
sprites[3] = 'Float.png'
sprites[4] = 'Cross.png'
sprites[5] = 'Dot.png'
sprites[6] = 'Base2.png'

for i = 1, #sprites do
    sprites[i] = love.graphics.newImage('sprites/'..sprites[i])
    sprites[i]:setFilter('nearest', 'nearest')
end

return sprites
