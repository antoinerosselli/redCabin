local Fade = {}
local moduleScene = require('moduleScene')
Fade.__index = Fade

function Fade:new(speed,state)
    local o = {}
    setmetatable(o, self)
    o.speed = speed
    o.state = state
    o.alpha = 1
    return o
end

function Fade:reset(alpha)
    self.alpha = alpha
end

function Fade:update(dt)
    if self.alpha >= 0 and self.alpha <= 1 then
        if self.state == 1 then
            self.alpha = math.min(1, self.alpha + self.speed * dt)
        end
        if self.state == 2 then
            self.alpha = math.min(1, self.alpha - self.speed * dt)
        end    
    end
end

function Fade:draw()
    love.graphics.setColor(0,0,0, self.alpha)
    love.graphics.rectangle("fill", -1000, -500, 5000, 5000) 
end

return Fade
