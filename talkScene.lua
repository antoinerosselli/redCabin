local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleTalk = require("moduleTalk")

TalkScene = {}
TalkScene.__index = TalkScene

function TalkScene:new(charac_one,charac_two,dialogue_box)
    local o = {}
    setmetatable(o, self)
    o.charac_one = charac_one
    o.charac_two = charac_two
    o.dialogue_box = dialogue_box
    return o
end

local quads_one = {}
local quads_two = {}
local currentFrame = 0
local frameTimer = 0
local frameDuration = 1


function TalkScene:load()
    for i = 0, 1 do
        quads_one[i] = love.graphics.newQuad(i * 100 , 0, 100 , 100, self.charac_one:getDimensions())
        quads_two[i] = love.graphics.newQuad(i * 100 , 0, 100 , 200, self.charac_two:getDimensions())
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
    love.graphics.draw(self.charac_one, quads_one[0],moduleParam.window_Width / 2 + 100 ,moduleParam.window_Height / 2, 0, 2,2)
    love.graphics.draw(self.charac_two, quads_two[currentFrame], moduleParam.window_Width / 2 - 200 ,moduleParam.window_Height / 2 - 300 , 0, 2,2)  
    self.dialogue_box:draw()
end

return TalkScene