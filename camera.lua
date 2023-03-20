local Camera = {}

function Camera:new(scaleX,scaleY)
    local object = {
        x = 0,
        y = 0,
        scaleX = 1,
        scaleY = 1
    }
    setmetatable(object, {__index = Camera})
    return object
end

function Camera:follow(target)
    self.x = target.x - love.graphics.getWidth() / 2 / self.scaleX
    self.y = target.y - love.graphics.getHeight() / 2 / self.scaleY
end


function Camera:set()
    love.graphics.push()
    love.graphics.translate(-self.x, -self.y)
    love.graphics.scale(self.scaleX, self.scaleY)
end

function Camera:unset()
    love.graphics.pop()
end

return Camera
