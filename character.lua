local moduleScene = require("module/moduleScene")
local Character = {}
Character.__index = Character

function Character:new(x,y,width,height,sprite,scale,callback,nbrFrame,speed)
    local o = {}
    setmetatable(o, self)
    o.x = x
    o.y = y
    o.width = width
    o.height = height
    o.sprites = sprite
    o.scale = scale or 1
    o.callback = callback or 'n/a'
    o.moveB = false
    o.destination = {}
    o.speed = speed or 1
    o.nbrFrame = nbrFrame
    o.quads = {}
    o.currentFrame = 0
    o.frameTimer = 0
    return o
end


function Character:callback()
    if  self.callback == 'n/a' then
    else
        self.callback(self)
    end
end

function Character:changeSkin(nSkin)
    self.sprites = love.graphics.newImage(nSkin)
    for i = 0, self.nbrFrame do
        self.quads[i] = love.graphics.newQuad(i * self.width , 0, self.width , self.height, self.sprites:getDimensions())
    end
end

function Character:move(x,y)
    self.destination = {x,y}
    self.moveB = true
end

function Character:load()
    for i = 0, self.nbrFrame do
        self.quads[i] = love.graphics.newQuad(i * self.width , 0, self.width , self.height, self.sprites:getDimensions())
    end      
end

function Character:update(dt)
    self.frameTimer = self.frameTimer + dt
    if self.frameTimer >= self.speed then
      self.currentFrame = self.currentFrame + 1
      self.frameTimer = 0
      if self.currentFrame > self.nbrFrame then 
        self.currentFrame = 0
    end 
    if self.moveB == true then
        if self.x > self.destination[1] then
          self.speed = -200
          self.x = self.x + self.speed * dt
        elseif self.x < self.destination[1] then
          self.speed = 200
          self.x = self.x + self.speed * dt
        end
        if self.y > self.destination[2] then
            self.speed = -200
            self.y = self.y + self.speed * dt
          elseif self.y < self.destination[2] then
            self.speed = 200
            self.y = self.y + self.speed * dt
        end
        if self.x == self.destination[1] and self.y == self.destination[2] then
            self.moveB = false
            self.destination = {}  
        end    
    end

end
end

function Character:draw()
    if self.currentFrame <= self.nbrFrame then
        love.graphics.draw(self.sprites, self.quads[self.currentFrame], self.x - 20,self.y - 10, 0, self.scale,self.scale )
    end
end

return Character