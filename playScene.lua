local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleSave = require("moduleSave")
local player = require('player')
local Camera = require("camera")
local gpMemberScene = require("gpMemberScene")
local CineScene = require("cineScene")


playScene = {}
playScene.__index = playScene

function playScene:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function nothing()
end


function vape_cine()
    local introSprite = love.graphics.newImage("img/vapeCine.png")
    local cineVape = CineScene:new(introSprite,moduleParam.window_Width / 2 - 350,moduleParam.window_Height /2 - 250,0.3,700,500,15, playScene, 1)
    moduleScene.currentScene = cineVape
end

function trajet_cine()
    local introSprite = love.graphics.newImage("img/trajet_to_estel_P01.png")
    local introSprite2 = love.graphics.newImage("img/trajet_to_estel_P02.png")
    local introSprite3 = love.graphics.newImage("img/trajet_to_estel_P03.png")
    local introSprite4 = love.graphics.newImage("img/trajet_to_estel_P04.png")
    local trajetCinep4 = CineScene:new(introSprite4,moduleParam.window_Width / 2 - 350,moduleParam.window_Height /2 - 250,0.3,700,500,12, playSceneTwo,1)
    local trajetCinep3 = CineScene:new(introSprite3,moduleParam.window_Width / 2 - 350,moduleParam.window_Height /2 - 250,0.3,700,500,17, trajetCinep4,1)
    local trajetCinep2 = CineScene:new(introSprite2,moduleParam.window_Width / 2 - 350,moduleParam.window_Height /2 - 250,0.3,700,500,12, trajetCinep3,1)
    local trajetCinep1 = CineScene:new(introSprite,moduleParam.window_Width / 2 - 350,moduleParam.window_Height /2 - 250,0.3,700,500,22, trajetCinep2,1)
    moduleScene.currentScene = trajetCinep1
end    

local function go_vape_act()
    local gpVape = {}
    local list_of_object = {}
    local list_of_set = {}
    local imgVape_object = love.graphics.newImage("img/vape_object.png")
    local imgDesk_object = love.graphics.newImage("img/deskOne.png")
    local vapeItem = Item:new(500,500,150,200, {1,1,1},vape_cine, imgVape_object)
    local deskSet = Item:new(0,0,700,500,{1,1,1},nothing,imgDesk_object,2)
    table.insert(list_of_object,vapeItem)
    table.insert(list_of_set,deskSet)
    gpVape = gpMemberScene:new(list_of_object,list_of_set)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = gpVape
end

local function go_letter_box()
    local gpBoite = {}
    local list_of_object_boite = {}
    local list_of_set_boite = {}
    local imgFlower_object = love.graphics.newImage("img/Noe_flower.png")
    local imgLetter_object = love.graphics.newImage("img/mdf_letter.png")
    local imgBoite_object = love.graphics.newImage("img/boite.png")
    function noe_doc()
        local noe_letter = DocumentScene:new("Noe","Merci pour la soirée d'hier, on refait ça quand tu veux <3","Pour Julie")
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = noe_letter
    end
    function mdf_doc()
        local mdf = DocumentScene:new("Ministère des fleurs","Votre prochain contrôle sera dans la ferme Estel. Merci de vous y présenter aujourd'hui.","Pour Julie")
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = mdf
    end
    local flowerItem = Item:new(moduleParam.window_Width /2 - 100 , moduleParam.window_Height /2 - 250 ,300,400, {1,1,1},noe_doc, imgFlower_object, 1.5)
    local letterItem = Item:new(moduleParam.window_Width /2 - 300, moduleParam.window_Height /2 ,300,200, {1,1,1},mdf_doc, imgLetter_object)
    local boiteItem = Item:new(moduleParam.window_Width /2 - 450, moduleParam.window_Height /2 - 450,500,500, {1,1,1},nothing, imgBoite_object,1.8)
    table.insert(list_of_object_boite, boiteItem)
    table.insert(list_of_object_boite,flowerItem)
    table.insert(list_of_object_boite,letterItem)
    gpBoite = gpMemberScene:new(list_of_object_boite,list_of_set_boite)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = gpBoite
end

local buttons = {}
local items_collide = {}
local items_noCollide = {}
local items_interact = {}

local imgCanap = love.graphics.newImage("img/canape.png")
local imgLit = love.graphics.newImage("img/lit.png")
local imgVape = love.graphics.newImage("img/vape.png")
local imgLettre = love.graphics.newImage("img/boiteolettre.png")
local imgDoor = love.graphics.newImage("img/door.png")

-------- Les murs
local wallone = Item:new(100, 600, 700, 100,{0.6,0.6,0.6})
local walltwo = Item:new(100, 200, 100, 400,{0.6,0.6,0.6})
local walltrois = Item:new(100, 100, 1400, 100,{0.6,0.6,0.6})
local wallcinq = Item:new(600, 500,100,100,{0.6,0.6,0.6})
local wallsix = Item:new(1500,100,100,1100,{0.6,0.6,0.6})
local wallseven = Item:new(700,600,100,600,{0.6,0.6,0.6})
local walleight = Item:new(700,1200,900,100,{0.6,0.6,0.6})
-------- Les collides
local canape = Item:new(1000,600,200,300, {1,1,1},go_vape_act, imgCanap)
local lit = Item:new(200,400,300,200, {1,1,1},nothing, imgLit)
local tablevape = Item:new(800,200,150,100, {1,1,1}, go_vape_act, imgVape)
local boiteolettre = Item:new(900,1200,100,100, {1,1,1},go_letter_box, imgLettre)
local door = Item:new(1100,1200,100,100, {1,1,1},trajet_cine,imgDoor)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide, wallcinq)
table.insert(items_collide, wallsix)
table.insert(items_collide, wallseven)
table.insert(items_collide, walleight)
table.insert(items_collide, canape)
table.insert(items_collide, lit)
table.insert(items_collide, tablevape)
table.insert(items_collide, boiteolettre)
table.insert(items_collide,door)

local fade = Fade:new(0.2,2)

------- Les interacts
table.insert(items_interact,boiteolettre)
table.insert(items_interact,tablevape)
table.insert(items_interact,door)

local me = player:new(200, 200, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)

function playScene:load()
    fade:reset(1)
    moduleScene.PlayScene = playScene
    me:spawn()
end

function playScene:update(dt)
    moduleSave:Save("playScene")
    fade:update(dt)
    camera:follow(me)
    me:update(dt)
    moduleScene.posxme = me.x
    moduleScene.posyme = me.y
    for _, button in ipairs(buttons) do
        button:update()
    end
    for _, item in ipairs(items_collide) do
        item:update()
    end
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
end

function playScene:draw()
    camera:set()
    for _, button in ipairs(buttons) do
        button:draw()
    end
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    for _, item in ipairs(items_noCollide) do
        item:draw()
    end
    me:draw()
    if moduleScene.fadeOk == true then
        fade:draw()
    end
    camera:unset()
end

return playScene