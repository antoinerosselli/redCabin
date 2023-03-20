local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("module/moduleScene")
local moduleSave = require("module/moduleSave")
local player = require('player')
local Camera = require("camera")
local Character = require("character")
local dialogue_box = require("dialogueBox")
local talkScene = require("talkScene")
local event = require("event")

gameInTheDark = {}
gameInTheDark.__index = gameInTheDark

function gameInTheDark:new()
    local o = {
        timer = 3,
        timeElapsed = 0,
        text = "none"
    }
    setmetatable(o, self)
    return o
end

phase_lapin = 1

local spritelapin1 = love.graphics.newImage("img/lapin1.png")
local spritelapin2 = love.graphics.newImage("img/lapin2.png")
local spritelapin3 = love.graphics.newImage("img/lapin3.png")

local function nextLapin()
    if phase_lapin == 2 then
        lapin:tp(-1000,-500)
        lapin:changeSkin("img/lapin3.png")
        phase_lapin = 3
    end
    if phase_lapin == 1 then
        lapin:tp(10,10)
        lapin:changeSkin("img/lapin2.png")
        phase_lapin = 2
    end
end

local items_collide = {}
local items_interact = {}

lapin = Character:new(2000,1100,100,100,spritelapin1,1,nextLapin,0,1)
lapin:load()

table.insert(items_collide,lapin)
table.insert(items_interact,lapin)

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function gameInTheDark:load()
    me:spawn()
    fade:reset(1)
    self.timer = 3
    self.timeElapsed = 0 
    self.text = "none"
    moduleScene.PlayScene = moduleScene.currentScene
end

function gameInTheDark:update(dt)
    moduleSave:Save("gameInTheDark")
    camera:follow(me)
    fade:update(dt)
    self.timeElapsed = self.timeElapsed + dt 
    if self.timeElapsed >= self.timer then
        gameInTheDark:indication(lapin)
        self.timeElapsed = 0 
    end
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    me:update(dt)
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
end

function gameInTheDark:draw()
    love.graphics.setColor(1, 1, 1) 
    camera:set()
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
    if self.text == "none" then
    else
        love.graphics.setColor(0, 0, 1) 
        love.graphics.print(self.text, me.x, me.y + 100) 
        love.graphics.setColor(1, 1, 1)     
    end
    camera:unset()
end

function gameInTheDark:indication(lapin)

    local direction = love.math.random(2) == 1
    local text = "none"

    if  direction then
        if lapin.x < me.x then
            text = "LEFT !"
        end
        if lapin.x > me.x then
            text = "RIGHT !"
        end    
    else 
        if lapin.y > me.y then
            text = "DOWN !"
        end
        if lapin.y < me.y then
            text = "UP !"
        end    
    end
    self.text = text

end

function gameInTheDark:lapin()

end

return gameInTheDark