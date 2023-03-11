local event = {}

function event:new(x, y, width,height,trigger)
    local object = {
        x = x,
        y = y,
        width = width,
        height = height,
        trigger = trigger,
    }
    setmetatable(object, {__index = event})
    return object
end

function event:trigger()
    self.trigger(self)
end

function event:update(me)
    if self:checkCollision(self.x, self.y, self.width, self.height, me.x , me.y, me.width , me.height) then
        self:trigger()
    end
end

function event:checkCollision(x,y,width,height,vx,vy,vwidth,vheight)
        local eventLeft = x
        local eventTop = y
        local eventRight = x + width
        local eventBottom = y + height
        local itemLeft = vx
        local itemTop = vy
        local itemRight = vx + vwidth
        local itemBottom = vy + vheight
        if eventRight > itemLeft and
            eventLeft < itemRight and
            eventBottom > itemTop and
            eventTop < itemBottom then
            return true
        else
            return false
        end    
end

function event:draw()
    love.graphics.setColor(1,1,0)   
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1)   
end


return event