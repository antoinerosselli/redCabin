local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleSave = require("moduleSave")
local player = require('player')
local Camera = require("camera")
local Character = require("character")
local gpMemberScene = require("gpMemberScene")
local dialogue_box = require("dialogueBox")
local CineScene = require("cineScene")
local talkScene = require("talkScene")

playSceneShadow = {}
playSceneShadow.__index = playSceneShadow

function playSceneShadow:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local buttons = {}
local items_collide = {}
local items_interact = {}

-------- Les murs
-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{138/250, 43/250, 226/250})
local walltwo = Item:new(-200, 600, 1400, 100,{138/250, 43/250, 226/250})
local walltrois = Item:new(-200, 1800, 1400, 100,{138/250, 43/250, 226/250})
local wallquatre = Item:new(1100, 600, 100, 1300,{138/250, 43/250, 226/250})
local spritePortal = love.graphics.newImage("img/shadow_Portal.png")
local spriteLogan = love.graphics.newImage("img/shadow_logan.png")
local Logan = Character:new(400,1000,100,200,spriteLogan,2,nothing,1,1)
local Portal = Item:new(450,600,100,200,{1,1,1},nothing,spritePortal,1)
Logan:load()

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide, wallquatre)
table.insert(items_collide, Logan)
table.insert(items_collide, Portal)

table.insert(items_interact,Logan)
table.insert(items_interact,Portal)

local me = player:new(400, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneShadow:load()
    me:spawn()
    fade:reset(1)
end

function playSceneShadow:update(dt)
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

function playSceneShadow:draw()
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

return playSceneShadow