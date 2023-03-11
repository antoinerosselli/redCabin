local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local moduleSave = require("module/moduleSave")
local player = require('player')
local Camera = require("camera")
local Character = require("character")
local gpMemberScene = require("gpMemberScene")
local dialogue_box = require("dialogueBox")
local CineScene = require("cineScene")
local talkScene = require("talkScene")

playSceneTen = {}
playSceneTen.__index = playSceneTen

function playSceneTen:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local spriteMaison = love.graphics.newImage("img/maison_out.png")
local spriteFance = love.graphics.newImage("img/barrière.png")
local spriteCamionGabi = love.graphics.newImage("img/camion_de_gabi.png")

local buttons = {}
local items_collide = {}
local items_interact = {}

local function talkWithGabi()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Je peux vous pretez la voiture pour aujourd'hui",""}
    local dialGabiJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkGabiJulie = talkScene:new(true,Julie,2,Gabi,1,{100,100,150,200},dialGabiJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkGabiJulie
end

local function goInHome()
    moduleScene.currentScene = playSceneSeven
end

local spriteGabi = love.graphics.newImage("img/gabi_big.png")
local Gabi = Character:new(730,1450,150,200,spriteGabi,1.2,talkWithGabi,1,2)
Gabi:load()

-------- Les murs
local wallone = Item:new(-150, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(-150, 600, 1350, 100,{0.6,0.8,0.5})
local walltrois = Item:new(-150, 1800, 700, 100,{0.6,0.8,0.5})
local walltroistwo = Item:new(700, 1800, 600, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1200, 600, 100, 1200,{0.6,0.8,0.5})
local CamionGabi = Item:new(450,1900,500,300,{1,1,1},nothing,spriteCamionGabi,1)
local maison = Item:new(150,500,1000,540,{1,1,1},goInHome,spriteMaison,1.2)
local fance = Item:new(950,1040,200,100,{1,1,1},nothing,spriteFance,1)
local fancetwo = Item:new(0,1040,200,100,{1,1,1},nothing,spriteFance,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,CamionGabi)
table.insert(items_collide,maison)
table.insert(items_collide,fance)
table.insert(items_collide,fancetwo)
table.insert(items_collide,Gabi)

table.insert(items_interact,Gabi)

local me = player:new(600, 1300, {0,1,0}, items_collide, items_interact)

local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneTen:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneTen:update(dt)
    moduleSave:Save("playSceneTen")
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

function playSceneTen:draw()
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

return playSceneTen