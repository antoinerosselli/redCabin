local Member = {}
Member.__index = Member

function Member:new(x, y, width, height, img,img_active, moveUpKey, moveDownKey, moveLeftKey, moveRightKey, activeKey)
    local o = {}
    setmetatable(o, self)
    o.x = x
    o.y = y
    o.originx = x
    o.originy = y
    o.width = width
    o.height = height
    o.image = love.graphics.newImage(img)
    o.image_active = love.graphics.newImage(img_active)
    o.image_tmp = love.graphics.newImage(img)
    o.moveUpKey = moveUpKey
    o.moveDownKey = moveDownKey
    o.moveLeftKey = moveLeftKey
    o.moveRightKey = moveRightKey
    o.activeKey = activeKey
    o.objectStock = nil
    return o
end


function Member:update(dt)
    if love.keyboard.isDown(self.moveUpKey) then
        self.y = math.max(0, self.y - dt * 200)
    end
    if love.keyboard.isDown(self.moveDownKey) then
        self.y = math.min(love.graphics.getHeight() - self.height, self.y + dt * 200)
    end
    if love.keyboard.isDown(self.moveLeftKey) then
        self.x = math.max(0, self.x - dt * 200)
    end
    if love.keyboard.isDown(self.moveRightKey) then
        self.x = math.min(love.graphics.getWidth() - self.width, self.x + dt * 200)
    end
    if love.keyboard.isDown(self.activeKey) then
        self.image = self.image_active
    end
    if not love.keyboard.isDown(self.activeKey) then
        self.image = self.image_tmp
    end
end

function Member:draw()
    love.graphics.draw(self.image, self.x, self.y,0, 1, 1)
end

return Member
