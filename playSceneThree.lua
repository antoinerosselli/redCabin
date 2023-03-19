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

playSceneThree = {}
playSceneThree.__index = playSceneThree

function playSceneThree:new()
    local o = {}
    setmetatable(o, self)
    return o
end


local function goNextPlace()
    moduleScene.currentScene = playSceneFour
end 

local function go_to_car()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big.png")
    local texts = {"On va ou ?","Dans ton cul",""}
    local dialCar = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local first_trip = TalkSceneInCar:new(Gabi,1.5,Julie,2.5,{150,200,100,100},dialCar,goNextPlace)
    moduleScene.currentScene = first_trip
end


local function talkWithSaul()
    local Saul = love.graphics.newImage("img/Saul_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Bonjour, c'est toi Saul ?","...Ouai...","C'est toi qui t'occupe de la récolte","...Ouai...","J'aurais besoin de toi demain","Ah ? Pourquoi ?","Je me présente Julie, je travaille pour le ministère des fleurs, je vais faire une petite inspection de l'endroit, rien de farfellu","Oh d'accord... Je vous montrerais tout ce que je fais ici...","Ne t'inquiète pas on a le temps, je reste 2 jours, donc on ce voit ce soir ?","Ok à ce soir...",""}
    local dialSaulJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkSaulJulie = talkScene:new(true,Julie,2,Saul,1,{100,100,100,230},dialSaulJulie,nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkSaulJulie
end

local function talkWithGabi()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Montez dans la voiture quand vous avez fini",""}
    local dialGabiJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkGabiJulie = talkScene:new(true,Julie,2,Gabi,1,{100,100,150,200},dialGabiJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkGabiJulie
end


local spriteCamionGabi = love.graphics.newImage("img/camion_de_gabi.png")
local spriteBle = love.graphics.newImage("img/big_ble.png")
local spriteMoulin = love.graphics.newImage("img/le_moulin.png")

local buttons = {}
local items_collide = {}
local items_interact = {}

local spriteGabi = love.graphics.newImage("img/gabi_big.png")
local spriteSaul = love.graphics.newImage("img/Saul_big.png")
-------- Les murs
-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(-200, 600, 1400, 100,{0.6,0.8,0.5})
local walltrois = Item:new(-200, 1800, 700, 100,{0.6,0.8,0.5})
local walltroistwo = Item:new(700, 1800, 600, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1200, 600, 100, 1200,{0.6,0.8,0.5})
local ble_one = Item:new(-100, 700, 300, 300,{1,1,1},nothing,spriteBle,1)
local ble_two = Item:new(200, 700, 300, 300,{1,1,1},nothing,spriteBle,1)
local ble_three = Item:new(500, 700, 300, 300,{1,1,1},nothing,spriteBle,1)
local ble_four = Item:new(800, 700, 300, 300,{1,1,1},nothing,spriteBle,1)
local ble_five = Item:new(900, 700, 300, 300,{1,1,1},nothing,spriteBle,1)
local CamionGabi = Item:new(450,1900,500,300,{1,1,1},go_to_car,spriteCamionGabi,1)
local Moulin = Character:new(800,500,400,650,spriteMoulin,1,nothing,8,1)
Moulin:load()
local Gabi = Character:new(730,1450,150,200,spriteGabi,1.2,talkWithGabi,1,2)
Gabi:load()
local Saul = Character:new(300,1000,100,230,spriteSaul,1,talkWithSaul,1,2.2)
Saul:load()

table.insert(items_interact,CamionGabi)
table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,CamionGabi)
table.insert(items_collide, ble_one)
table.insert(items_collide, ble_two)
table.insert(items_collide, ble_three)
table.insert(items_collide, ble_four)
table.insert(items_collide, ble_five)
table.insert(items_collide,CamionGabi)
table.insert(items_collide,Gabi)
table.insert(items_collide,Saul)
table.insert(items_collide,Moulin)

table.insert(items_interact,Gabi)
table.insert(items_interact,Saul)

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local function go_to_shadow()
    eventSHSaul.x = 3000
    local pssSaul = playSceneShadow:new(love.graphics.newImage('img/ShadowSaul.png'),"TA MÈRE LE CHAUVE GROS FILS DE PUTE",love.graphics.newImage("img/larmeSaul.png"),1.2)
    moduleScene.realworld = moduleScene.currentScene
    moduleScene.currentScene = pssSaul
end

eventSHSaul = event:new(900,1450,100,100,go_to_shadow)

local fade = Fade:new(0.2,2)

function playSceneThree:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneThree:update(dt)
    moduleSave:Save("playSceneThree")
    camera:follow(me)
    fade:update(dt)
    eventSHSaul:update(me)
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    me:update(dt)
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
    if 670 < Logan.y and 690 > Logan.y then
        Logan:changeSkin("img/Logan_no_move.png")
    end
end

function playSceneThree:draw()
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

return playSceneThree