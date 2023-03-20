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

playSceneOutCabin = {}
playSceneOutCabin.__index = playSceneOutCabin

function playSceneOutCabin:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function go_in_cabin()
    moduleScene.currentScene = playSceneInCabin
end

local buttons = {}
local items_collide = {}
local items_interact = {}

local spriteCabin = love.graphics.newImage("img/la_cabane.png")
local spriteBush = love.graphics.newImage("img/bush.png")

local wallone = Item:new(-200, 600, 100, 1200,{0,1,0})
local walltwo = Item:new(-200, 600, 1400, 100,{0,1,0})
local walltrois = Item:new(-200, 1800, 700, 100,{0,1,0})
local walltroistwo = Item:new(700, 1800, 600, 100,{0,1,0})
local wallquatre = Item:new(1200, 600, 100, 1200,{0,1,0})
local RedCabin = Character:new(550,1000,300,300,spriteCabin,1.3,go_in_cabin,0,1)
--add bush
RedCabin:load()

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,RedCabin)
table.insert(items_interact,RedCabin)

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneOutCabin:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneOutCabin:update(dt)
    moduleSave:Save("playSceneOutCabin")
    camera:follow(me)
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

function playSceneOutCabin:draw()
    camera:set()
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
    camera:unset()
end

return playSceneOutCabin