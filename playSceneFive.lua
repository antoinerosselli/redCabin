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

playSceneFive = {}
playSceneFive.__index = playSceneFive

function playSceneFive:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function goNextPlace()
    moduleScene.currentScene = playSceneSix
end 

local function go_to_car()
    local Gabi = love.graphics.newImage("gabi_big.png")
    local Julie = love.graphics.newImage("julie_big.png")
    local texts = {"On va ou ?","Dans ton cul",""}
    local dialCar = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local first_trip = TalkSceneInCar:new(Gabi,1.5,Julie,2.5,{150,200,100,100},dialCar,goNextPlace)
    moduleScene.currentScene = first_trip
end

local function talkWithGabi()
    local Gabi = love.graphics.newImage("gabi_big.png")
    local Julie = love.graphics.newImage("julie_big_up.png")
    local texts = {"Il est là ?","Non j'ai pas l'impression ","C'est normal ?","Non, il doit sûrement être encore en ville, on va continuer vous allez le voir ce soir",""}
    local dialGabiJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkGabiJulie = talkScene:new(true,Julie,2,Gabi,1,{100,100,150,200},dialGabiJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkGabiJulie
end


local spriteCamionGabi = love.graphics.newImage("camion_de_gabi.png")
local spritegrillage = love.graphics.newImage("grillage.png")

local buttons = {}
local items_collide = {}
local items_interact = {}

-------- Les murs
-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(-200, 600, 1400, 100,{0.6,0.8,0.5})
local walltrois = Item:new(-200, 1800, 600, 100,{0.6,0.8,0.5})
local walltroistwo = Item:new(700, 1800, 500, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1100, 600, 100, 1300,{0.6,0.8,0.5})
local grillage_one = Item:new(-100, 1000, 300, 300,{1,1,1},nothing,spritegrillage,1)
local grillage_two = Item:new(200, 1000, 300, 300,{1,1,1},nothing,spritegrillage,1)
local grillage_three = Item:new(500, 1000, 300, 300,{1,1,1},nothing,spritegrillage,1)
local grillage_four = Item:new(800, 1000, 300, 300,{1,1,1},nothing,spritegrillage,1)
local CamionGabi = Item:new(350,1900,500,300,{1,1,1},go_to_car,spriteCamionGabi,1)
local spriteGabi = love.graphics.newImage("gabi_big.png")
local Gabi = Character:new(730,1450,150,200,spriteGabi,1.2,talkWithGabi,1,2)
Gabi:load()

table.insert(items_interact,CamionGabi)
table.insert(items_interact,Gabi)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,CamionGabi)
table.insert(items_collide, grillage_one)
table.insert(items_collide, grillage_two)
table.insert(items_collide, grillage_three)
table.insert(items_collide, grillage_four)
table.insert(items_collide, Gabi)




local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneFive:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneFive:update(dt)
    moduleSave:Save("playSceneFive")
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
    if 670 < Logan.y and 690 > Logan.y then
        Logan:changeSkin("Logan_no_move.png")
    end
end

function playSceneFive:draw()
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

return playSceneFive