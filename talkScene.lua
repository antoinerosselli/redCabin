local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local moduleSave = require("module/moduleSave")

TalkScene = {}
TalkScene.__index = TalkScene

function TalkScene:new(pj,charac_one,scale_one,charac_two,scale_two,spriteSize,dialogue_box,nextAction,arg1)
    local o = {}
    setmetatable(o, self)
    o.pj = pj
    o.charac_one = charac_one
    o.size_one = scale_one
    o.charac_two = charac_two
    o.size_two = scale_two
    o.spriteSize = spriteSize
    o.dialogue_box = dialogue_box
    o.nextAction = nextAction
    o.arg1 = arg1
    return o
end

local quads_one = {}
local quads_two = {}
local currentFrame = 0
local frameTimer = 0
local frameDuration = 1

function TalkScene:load()
    moduleScene.fadeOk = false
    self.nextAction()
    for i = 0, 1 do
        quads_one[i] = love.graphics.newQuad(i * self.spriteSize[1] , 0, self.spriteSize[1] , self.spriteSize[2], self.charac_one:getDimensions())
        quads_two[i] = love.graphics.newQuad(i * self.spriteSize[3] , 0, self.spriteSize[3] , self.spriteSize[4], self.charac_two:getDimensions())
    end
end

function TalkScene:update(dt)
    self.dialogue_box:update()
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

function TalkScene:draw()
    if self.pj == true then
        love.graphics.draw(self.charac_one, quads_one[0],moduleParam.window_Width / 2 + 100 ,moduleParam.window_Height / 2, 0, self.size_one,self.size_one)
        love.graphics.draw(self.charac_two, quads_two[currentFrame], moduleParam.window_Width / 2 - 200 ,moduleParam.window_Height / 2 - 300 , 0, self.size_two,self.size_two)  
        self.dialogue_box:draw()    
    else
        love.graphics.draw(self.charac_one, quads_one[0],moduleParam.window_Width / 2 + 100 ,moduleParam.window_Height / 2, 0, self.size_one,self.size_one)
        love.graphics.draw(self.charac_two, quads_two[currentFrame], moduleParam.window_Width / 2 - 200 ,moduleParam.window_Height / 2 - 300 , 0, self.size_two,self.size_two)  
        self.dialogue_box:draw()    
    end
end

return TalkScene