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

playSceneNine = {}
playSceneNine.__index = playSceneNine

function playSceneNine:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function gophaseTwo ()
    moduleScene.currentScene = playSceneTen
end 

local items_collide = {}
local items_interact = {}

local spriteDoor = love.graphics.newImage("img/door.png")
local spriteClientOne = love.graphics.newImage("img/clientOne.png")
local spriteClientTwo = love.graphics.newImage("img/clientTwo.png")
local spriteClientThree = love.graphics.newImage("img/clientThree.png")
local spriteClientFour = love.graphics.newImage("img/clientFour.png")
local spriteClientFive = love.graphics.newImage("img/clientFive.png")
local spriteClientNOE = love.graphics.newImage("img/clientNOE.png")

-------- Les murs
local wallone = Item:new(-150, 600, 100, 1200,{255/255, 192/255, 203/255})
local walltwo = Item:new(-150, 600, 1350, 100,{255/255, 192/255, 203/255})
local walltrois = Item:new(-150, 1800, 1450, 100,{255/255, 192/255, 203/255})
local wallquatre = Item:new(1200, 600, 100, 1200,{255/255, 192/255, 203/255})
local door = Item:new(550, 1800, 100, 100,{255/255, 192/255, 203/255},nothing,spriteDoor,1)
local clientOne = Item:new(100, 1500 ,350,200, {1,1,1},nothing,spriteClientOne,1)
local clientTwo = Item:new(100, 1200, 350, 200, {1,1,1},nothing, spriteClientTwo,1)
local clientThree = Item:new(100, 900, 350, 200, {1,1,1},nothing, spriteClientThree,1)
local clientFour= Item:new(800, 900, 350, 200, {1,1,1},nothing, spriteClientFour,1)
local clientFive= Item:new(800, 1500, 350, 200, {1,1,1},nothing, spriteClientFive,1)
local clientNOE = Item:new(800, 1200, 350, 200, {1,1,1},gophaseTwo, spriteClientNOE,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide, wallquatre)
table.insert(items_collide, clientOne)
table.insert(items_collide, clientTwo)
table.insert(items_collide, clientThree)
table.insert(items_collide, clientFour)
table.insert(items_collide, clientFive)
table.insert(items_collide, clientNOE)

table.insert(items_collide, door)
table.insert(items_interact, clientNOE)


local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)

local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneNine:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneNine:update(dt)
    moduleSave:Save("playSceneNine")
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

function playSceneNine:draw()
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

return playSceneNine