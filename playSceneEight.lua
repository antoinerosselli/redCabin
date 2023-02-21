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

playSceneEight = {}
playSceneEight.__index = playSceneEight

function playSceneEight:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function gotToNoe()
    moduleScene.currentScene = playSceneNine
end

local function chestActivity()
        local gpBoite = {}
        local list_of_object_boite = {}
        local list_of_set_boite = {}
        local imgFlower_object = love.graphics.newImage("img/recetas_de_mama.png")
        local flowerItem = Item:new(moduleParam.window_Width /2 - 100 , moduleParam.window_Height /2 - 250 ,300,400, {1,1,1},nothing, imgFlower_object, 2)
        table.insert(list_of_object_boite,flowerItem)
        gpBoite = gpMemberScene:new(list_of_object_boite,list_of_set_boite)
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = gpBoite    
end

local items_collide = {}
local items_interact = {}

local spriteDoor = love.graphics.newImage("img/door.png")
local spriteLit = love.graphics.newImage('img/nlit.png')
local spriteChest = love.graphics.newImage("img/chest.png")

-------- Les murs
local wallone = Item:new(-150, 900, 100, 900,{139/255, 69/255, 19/255})
local walltwo = Item:new(-150, 900, 1350, 100,{139/255, 69/255, 19/255})
local walltrois = Item:new(-150, 1800, 1450, 100,{139/255, 69/255, 19/255})
local wallquatre = Item:new(1200, 900, 100, 900,{139/255, 69/255, 19/255})
local door = Item:new(550, 1800, 100, 100,{1,1,1},gotToNoe,spriteDoor,1)
local lit = Item:new(0, 1200, 300, 200,{1,1,1},gotToNoe,spriteLit,1)
local chest = Item:new(500, 1000, 200, 100,{1,1,1},chestActivity,spriteChest,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide, wallquatre)
table.insert(items_collide, door)
table.insert(items_collide, lit)
table.insert(items_collide, chest)
table.insert(items_interact, door)
table.insert(items_interact, chest)

local me = player:new(600, 1450, {1,1,1}, items_collide, items_interact)

local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneEight:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneEight:update(dt)
    moduleSave:Save("playSceneEight")
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

function playSceneEight:draw()
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

return playSceneEight