local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleSave = require("moduleSave")
local miniPlayer = require('miniPlayer')
local Camera = require("camera")
local Character = require("character")
local gpMemberScene = require("gpMemberScene")
local dialogue_box = require("dialogueBox")
local CineScene = require("cineScene")
local talkScene = require("talkScene")

gameCollectMemo = {}
gameCollectMemo.__index = gameCollectMemo

function gameCollectMemo:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local items_collide = {}
local items_interact = {}

-------- Les murs
-------- Les murs
local wallone = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200, 10, 400,{138/250, 43/250, 226/250})
local walltwo = Item:new(moduleParam.window_Width / 2 + 200, moduleParam.window_Height / 2 - 200, 10, 400,{138/250, 43/250, 226/250})
local wallthree = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200, 400, 10,{138/250, 43/250, 226/250})
local wallfour = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 + 190, 400, 10,{138/250, 43/250, 226/250})

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, wallthree)
table.insert(items_collide, wallfour)

local me = miniPlayer:new(500, 500, {1,0,0}, items_collide, items_interact)

local fade = Fade:new(0.2,2)

function gameCollectMemo:load()
    me:spawn()
    fade:reset(1)
end

function gameCollectMemo:update(dt)
    fade:update(dt)
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    me:update(dt)
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
end

function gameCollectMemo:draw()
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
end

return gameCollectMemo