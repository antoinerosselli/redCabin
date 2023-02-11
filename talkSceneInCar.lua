local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleTalk = require("moduleTalk")

TalkSceneInCar = {}
TalkSceneInCar.__index = TalkSceneInCar

function TalkSceneInCar:new(charac_one,size_one,charac_two,size_two,spriteSize,dialogue_box,nextAction,arg1)
    local o = {}
    setmetatable(o, self)
    o.charac_one = charac_one
    o.size_one = size_one
    o.charac_two = charac_two
    o.size_two = size_two
    o.spriteSize = spriteSize
    o.dialogue_box = dialogue_box
    o.nextAction = nextAction
    o.arg1 = arg1
    o.background = love.graphics.newImage("inthecar.png")
    return o
end

local quads_one = {}
local quads_two = {}
local currentFrame = 0
local frameTimer = 0
local frameDuration = 1

function TalkSceneInCar:load()
    moduleScene.fadeOk = false
    for i = 0, 1 do
        quads_one[i] = love.graphics.newQuad(i * self.spriteSize[1] , 0, self.spriteSize[1] , self.spriteSize[2], self.charac_one:getDimensions())
        quads_two[i] = love.graphics.newQuad(i * self.spriteSize[3] , 0, self.spriteSize[3] , self.spriteSize[4], self.charac_two:getDimensions())
    end
end

function TalkSceneInCar:update(dt)
    self.dialogue_box:update(self.nextAction)
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
    frameTimer = frameTimer + dt
    if frameTimer >= frameDuration then
      currentFrame = currentFrame + 1
      frameTimer = 0
      if currentFrame > 1 then 
        currentFrame = 0
      end
    end
end

function TalkSceneInCar:draw()
    love.graphics.draw(self.charac_one, quads_one[currentFrame],moduleParam.window_Width / 2 + 50 ,moduleParam.window_Height / 2 - 150, 0, self.size_one,self.size_one)
    love.graphics.draw(self.charac_two, quads_two[currentFrame], moduleParam.window_Width / 2 - 280 ,moduleParam.window_Height / 2 - 130 , 0, self.size_two,self.size_two)  
    love.graphics.draw(self.background,moduleParam.window_Width / 2 - 350 , moduleParam.window_Height / 2 -  250 ,0,1,1)
    self.dialogue_box:draw()
end

return TalkSceneInCar