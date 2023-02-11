local moduleScene = require("moduleScene")
local Camera = require("camera")

CineScene = {}
CineScene.__index = CineScene

function CineScene:new(plans,posX,posY,speed,width,height,lastFrame,nextScene, scale)
    local o = {}
    setmetatable(o, self)
    o.sprites = plans
    o.posX = posX
    o.posY = posY
    o.speed = speed
    o.nextScene = nextScene
    o.width = width
    o.height = height
    o.lastFrame = lastFrame
    o.scale = scale or 1
    o.quads = {}
    return o
end

local spriteWidth, spriteHeight = 300, 300

local currentFrame = 0
local frameTimer = 0
local frameDuration = 0

function CineScene:load()
    moduleScene.fadeOk = true
    self.quads = {}
    moduleScene.cursorPresence = false
    frameDuration = self.speed
    currentFrame = 0
    frameTimer = 0
    for i = 0, self.lastFrame do
        self.quads[i] = love.graphics.newQuad(i * self.width - 0, 0, self.width - 0, self.height - 0, self.sprites:getDimensions())
    end      
end


function CineScene:update(dt)
    frameTimer = frameTimer + dt
        if frameTimer >= frameDuration then
          currentFrame = currentFrame + 1
          frameTimer = 0
          if currentFrame > self.lastFrame then 
            moduleScene.currentScene = self.nextScene
            moduleScene.cursorPresence = true
        end 
        end
end

function CineScene:draw()
    if currentFrame <= self.lastFrame then
        love.graphics.setColor({1,1,1})
        love.graphics.draw(self.sprites, self.quads[currentFrame], self.posX ,self.posY, 0, self.scale,self.scale )
    end
end

return CineScene