local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("module/moduleScene")
local player = require('player')
local Camera = require("camera")
local Character = require("character")

playSceneShadow = {}
playSceneShadow.__index = playSceneShadow

function playSceneShadow:new(spriteIndiv,words,sprite)
    local o = {
        spriteIndiv = spriteIndiv,
        words = words,
        sprite = sprite
    }
    setmetatable(o, self)
    return o
end

local buttons = {}
local items_collide = {}
local items_interact = {}

local function game()
    local memo = gameCollectMemo:new(WG,SG)
    moduleScene.currentScene = memo
end

local function realworld()
    items_collide = {}
    items_interact = {}
    moduleScene.currentScene = moduleScene.realworld
end

-------- Les murs
-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{138/250, 43/250, 226/250})
local walltwo = Item:new(-200, 600, 1400, 100,{138/250, 43/250, 226/250})
local walltrois = Item:new(-200, 1800, 1400, 100,{138/250, 43/250, 226/250})
local wallquatre = Item:new(1100, 600, 100, 1300,{138/250, 43/250, 226/250})
local spritePortal = love.graphics.newImage("img/shadow_Portal.png")
local Portal = Item:new(450,600,100,200,{1,1,1},realworld,spritePortal,1)


local me = player:new(400, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneShadow:load()
    WG = self.words
    SG = self.sprite
    table.insert(items_collide, wallone)
    table.insert(items_collide, walltwo)
    table.insert(items_collide, walltrois)
    table.insert(items_collide, wallquatre)
    table.insert(items_collide, Portal)
    table.insert(items_interact,Portal)
    local indiv = Character:new(400,1000,100,200,self.spriteIndiv,2,game,1,1)
    indiv:load()
    table.insert(items_collide, indiv)
    table.insert(items_interact,indiv)
    me:spawn()
    fade:reset(1)
end

function playSceneShadow:update(dt)
    camera:follow(me)
    fade:update(dt)
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    for _, item in ipairs(items_interact) do
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
    for _, item in ipairs(items_interact) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
    camera:unset()
end

return playSceneShadow