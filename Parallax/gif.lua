local Gif = {}
Gif.__index = Gif

function Gif.Create(gif, frames, horizontal)
    local self = setmetatable({}, Gif)
    
    self.gif = gif
    self.frames = frames
    self.horizontal = horizontal or true
    self.quads = {}
	local imgWidth, imgHeight = gif:getWidth(), gif:getHeight()
	local spriteWidth = imgWidth / frames
    local spriteHeight = imgHeight / frames
	for i = 0, frames - 1 do
        if self.horizontal then
		    table.insert(self.quads, love.graphics.newQuad(i * spriteWidth, 0, spriteWidth, imgHeight, imgWidth, imgHeight))
        else
            table.insert(self.quads, love.graphics.newQuad(0, i * spriteHeight, imgWidth, spriteHeight, imgWidth, imgHeight))
        end
	end

    return self
end

function Gif:draw(frame, x, y)
    love.graphics.draw(self.gif, self.quads[(math.floor(frame) % self.frames) + 1], x, y)
end

return Gif
