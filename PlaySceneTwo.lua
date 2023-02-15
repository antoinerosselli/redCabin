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
local TalkSceneInCar = require("talkSceneInCar")

playSceneTwo = {}
playSceneTwo.__index = playSceneTwo

function playSceneTwo:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function loganRun()
    Logan:changeSkin("img/Logan_move_up.png")
    Logan:move(600,680,'img/Logan_no_move.png')
end

local function goNextPlace()
    moduleScene.currentScene = playSceneThree
end 

local function go_to_car()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big.png")
    local texts = {"On va ou ?","Dans ton cul",""}
    local dialCar = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local first_trip = TalkSceneInCar:new(Gabi,1.5,Julie,2.5,{150,200,100,100},dialCar,goNextPlace)
    moduleScene.currentScene = first_trip
end

local function talkWithLogan()
    local Logan = love.graphics.newImage("img/Logan_no_move.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Salut toi , tu peux me dire où se trouve ton papa ?","Mon papa est devant la grange, il surveille les vaches","Est-ce que tu pourrais m'ammener vers lui ? J'aimerais lui parler","Oui ! Suis-moi",""}
    local dialLoganJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkLoganJulie = talkScene:new(true,Julie,2,Logan,2,{100,100,100,200},dialLoganJulie,loganRun)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkLoganJulie
end

local function talkWithGabi()
    local Gabi = love.graphics.newImage("img/gabi_big.png")
    local Julie = love.graphics.newImage("img/julie_big_up.png")
    local texts = {"Bonjour, qu'est ce que je peux faire pour vous ?","Bonjour je suis Julie, je viens de la part du ministère des fleurs. Vous avez demandez à acquérir des nouveaux terrains, je suis ici pour établir un dossier sur votre ferme","Oh ! Vous avez fait vite, moi c'est Gabi. Suivez-moi je vais vous faire un tour de la ferme",""}
    local dialLoganJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkLoganJulie = talkScene:new(true,Julie,2,Gabi,1,{100,100,150,200},dialLoganJulie, nothing)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkLoganJulie
end

local buttons = {}
local items_collide = {}
local items_noCollide = {}
local items_interact = {}
local characters = {}

local spriteGrange = love.graphics.newImage("img/grange.png")
local spriteLogan = love.graphics.newImage("img/Logan_no_move.png")
local spriteVacheOne = love.graphics.newImage("img/vache_miam_one.png")
local spriteGabi = love.graphics.newImage("img/gabi_big.png")
local spriteCamionGabi = love.graphics.newImage("img/camion_de_gabi.png")
local spriteEstelFarm = love.graphics.newImage("img/Estel_Farm.png")
local spriteVelo = love.graphics.newImage("img/bike.png")

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local Gabi = Character:new(730,680,150,200,spriteGabi,1.2,talkWithGabi,1,2)
Gabi:load()
Logan = Character:new(400,1400,100,130,spriteLogan,1.6,talkWithLogan,1,1)
Logan:load()
local VacheOne = Character:new(800,1000,300,150,spriteVacheOne,1,nothing,10,1)
VacheOne:load()
local VacheTwo = Character:new(700,1400,300,150,spriteVacheOne,1,nothing,10,3)
VacheTwo:load()
table.insert(characters,Logan)
local camera = Camera:new(me.x,me.y)

-------- Les murs
local wallone = Item:new(-200, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(-200, 600, 1400, 100,{0.6,0.8,0.5})
local walltrois = Item:new(-200, 1800, 700, 100,{0.6,0.8,0.5})
local walltroistwo = Item:new(700, 1800, 600, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1200, 600, 100, 1200,{0.6,0.8,0.5})
local grange = Item:new(190,300,700,500,{1,1,1},nothing,spriteGrange,1)
local CamionGabi = Item:new(0,750,500,300,{1,1,1},go_to_car,spriteCamionGabi,1)
local EstelFarm = Item:new(0,1600,500,300,{1,1,1},nothing,spriteEstelFarm,1)
local Velo = Item:new(500,1800,200,150,{1,1,1},nothing,spriteVelo,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide,walltroistwo)
table.insert(items_collide, wallquatre)
table.insert(items_collide,VacheOne)
table.insert(items_collide,VacheTwo)
table.insert(items_collide,grange)
table.insert(items_collide,CamionGabi)
table.insert(items_collide,Velo)
table.insert(items_collide,EstelFarm)
table.insert(items_collide,Logan)
table.insert(items_collide,Gabi)

table.insert(items_interact,Gabi)
table.insert(items_interact,Logan)
table.insert(items_interact,CamionGabi)

local fade = Fade:new(0.2,2)

function playSceneTwo:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneTwo:update(dt)
    moduleSave:Save("playSceneTwo")
    camera:follow(me)
    fade:update(dt)
    for _, character in ipairs(characters) do
        character:update(dt)
    end
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

function playSceneTwo:draw()
    camera:set()
    for _, character in ipairs(characters) do
        character:draw()
    end
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
    camera:unset()
end

return playSceneTwo