local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local event = require("event")

gameCourse = {}
gameCourse.__index = gameCourse

function gameCourse:new(words)
    local o = {
    }
    setmetatable(o, self)
    o.words = words
    return o
end

local buttons = {}
local items_collide = {}
local event_list = {}

local me = Item:new(100, moduleParam.window_Height - 250, 20, 20,{1, 0,1})
local pas = 0

function gameCourse:load()
    self.fade = Fade:new(0.2,2)
    self.fade:reset(1)
    me.x = 100
    pas = 0
end

local function testevent()
    print("test")
end

local function wakeup()
    moduleScene.currentScene = moduleScene.PlayScene
end
local state = 1

local buttonContinue = Button:new(moduleParam.window_Width / 2 - 100, moduleParam.window_Height - 180  , 200, 100, {0, 0, 0}, "réveil",{1, 1, 1}, wakeup) 
table.insert(buttons, buttonContinue)
-------- Les murs
local wallone = Item:new(0, moduleParam.window_Height - 200, moduleParam.window_Width, 10,{1, 1,1})
-------- Runner
local eventOne = event:new(200, 90, 100,100,testevent)

table.insert(event_list, eventOne)
table.insert(items_collide, wallone)
table.insert(items_collide,me)

function gameCourse:update(dt)
    self.fade:update(dt)
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
    if love.keyboard.isDown("a") and state == 1 and not love.keyboard.isDown("e") then
        me.x = me.x + 3
        pas = pas + 3
        state = 2
    end
    if love.keyboard.isDown("e") and state == 2 and not love.keyboard.isDown("a") then
        me.x = me.x + 3
        pas = pas + 3
        state = 1
    end
    if pas == moduleParam.window_Width / 2 + 300 then
        moduleScene.currentScene = sceneTestMenu
    end
    for _, ev in ipairs(event_list) do
        ev:update(me)
    end
end

function gameCourse:draw()
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    for _, item in ipairs(event_list) do
        item:draw()
    end
    if moduleScene.fadeOk == true then
        self.fade:draw()
    end
    love.graphics.setColor({1,1,1})
end

return gameCourse