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
local event = require("event")

playSceneFour = {}
playSceneFour.__index = playSceneFour

function playSceneFour:new()
    local o = {}
    setmetatable(o, self)
    return o
end


local buttons = {}
local items_collide = {}
local items_interact = {}

local function goNextPlace()
    moduleScene.currentScene = playSceneFive
end 

local function go_to_car()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big.png")
    local texts = {"On va ou ?","Dans ton cul",""}
    local dialCar = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local first_trip = TalkSceneInCar:new(Gabi,1.5,Julie,2.5,{150,200,100,100},dialCar,goNextPlace)
    moduleScene.currentScene = first_trip
end


local function talkWithGabi()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"...","ça va ?","Oui, R.A.S",""}
    local dialGabiJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkGabiJulie = talkScene:new(true,Julie,2,Gabi,1,{100,100,150,200},dialGabiJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkGabiJulie
end

local function talkWithVache()
    local Vache = love.graphics.newImage("img/vache_miam_one.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Meuh","oui ?","Meuh Meuh","D'accord...",""}
    local dialVacheJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkVacheJulie = talkScene:new(true,Julie,2,Vache,1,{100,100,300,150},dialVacheJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkVacheJulie
end

local function talkWithSofia()
    local Sofia = love.graphics.newImage("img/Sofia_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Bonjour ???","Bonjour Madame !","Vous m'attendiez ?","Ah eee moi non pas du tout !","Vous allez bien ?","Oui pardon pardon, c'était une journée épuisante, je m'appelle Sofia. Bienvenue à la ferme Estel","Merci ! Moi c'est Julie je suis venu pour faire un petit contrôle de routine de votre ferme.","Oui oui je m'en doutais vous restez combien de temps ?","Deux jours, pour m'assurer que tout ce va bien et bien tout vérifier","D'accord d'accord","...","...","Bon je vais continuer la visite à ce soir",""}
    local dialSofiaJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkSofiaJulie = talkScene:new(true,Julie,2,Sofia,1.3,{100,100,100,200},dialSofiaJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkSofiaJulie
end

local function go_to_shadow()
    eventSHSofia.x = 3000
    local pssSaul = playSceneShadow:new(love.graphics.newImage('img/ShadowSofia.png'),"TON ANUS LE CHAUVE GROS FILS DE POUTINE",love.graphics.newImage("img/bloodsofia.png"),1.2)
    moduleScene.realworld = moduleScene.currentScene
    moduleScene.currentScene = pssSaul
end

eventSHSofia = event:new(900,1450,100,100,go_to_shadow)


local spriteCamionGabi = love.graphics.newImage("img/camion_de_gabi.png")
local spriteSilo = love.graphics.newImage("img/silo.png")
local spriteReserve = love.graphics.newImage("img/reserve.png")
-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(-200, 600, 1400, 100,{0.6,0.8,0.5})
local walltrois = Item:new(-200, 1800, 700, 100,{0.6,0.8,0.5})
local walltroistwo = Item:new(700, 1800, 600, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1200, 600, 100, 1200,{0.6,0.8,0.5})
local CamionGabi = Item:new(450,1900,500,300,{1,1,1},go_to_car,spriteCamionGabi,1)
local reserve = Item:new(150,700,600,500,{1,1,1},nothing,spriteReserve,1.1)
local silo_un = Item:new(800,400,400,650,{1,1,1},nothing,spriteSilo,1)
local silo_deux = Item:new(800,600,400,650,{1,1,1},nothing,spriteSilo,1)
local spriteGabi = love.graphics.newImage("img/gabi_big.png")
local Gabi = Character:new(730,1450,150,200,spriteGabi,1.2,talkWithGabi,1,2)
Gabi:load()
local spriteSofia = love.graphics.newImage("img/Sofia_big.png")
local Sofia = Character:new(600,1080,100,200,spriteSofia,1.3,talkWithSofia,1.3,2)
Sofia:load()
local spriteVacheOne = love.graphics.newImage("img/vache_miam_one.png")
local VacheOne = Character:new(-50,1280,300,150,spriteVacheOne,1,talkWithVache,10,1)
VacheOne:load()

table.insert(items_interact,CamionGabi)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,CamionGabi)
table.insert(items_collide,reserve)
table.insert(items_collide,silo_un)
table.insert(items_collide,silo_deux)
table.insert(items_collide,Gabi)
table.insert(items_collide,Sofia)
table.insert(items_collide,VacheOne)

table.insert(items_interact,VacheOne)
table.insert(items_interact,Gabi)
table.insert(items_interact,Sofia)

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

local fade = Fade:new(0.2,2)

function playSceneFour:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneFour:update(dt)
    moduleSave:Save("playSceneFour")
    camera:follow(me)
    fade:update(dt)
    eventSHSofia:update(me)
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

function playSceneFour:draw()
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

return playSceneFour