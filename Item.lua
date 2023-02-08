local moduleScene = require("moduleScene")
local Item = {}
Item.__index = Item

function Item:new(x,y,width,height,color,callbacks,sprite,scale)
    local o = {}
    setmetatable(o, self)
    o.x = x
    o.y = y
    o.width = width
    o.height = height
    o.color = color
    o.callback = callbacks or 'n/a'
    o.sprite = sprite or 'n/a'
    o.scale = scale or 1
    return o
end

function Item:callback()
    if  self.callback == 'n/a' then
    else
        self.callback(self)
    end
end

function Item:update(dt)
end

function Item:draw()
    if self.sprite == 'n/a' then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
        love.graphics.setColor(1,1,1)   
    else
        love.graphics.draw(self.sprite, self.x, self.y,0,self.scale,self.scale)
    end
end

return Item