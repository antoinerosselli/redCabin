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

playSceneTwo = {}
playSceneTwo.__index = playSceneTwo

function playSceneTwo:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local function talkWithLogan()
    local Logan = love.graphics.newImage("Logan_no_move.png")
    local Julie = love.graphics.newImage("julie_big_up.png")
    local texts = {"allo je suis le dieu de la nourriture un dieu avide de miam miam ou de miam moum bien evidemment personne ne peut me stopper dans ce monde de fou","oui ?",""}
    local dialLoganJulie = dialogue_box:new(texts,{1,1,1},{0,0,1})
    local talkLoganJulie = talkScene:new(Julie,Logan,dialLoganJulie)
    moduleScene.oldScene = moduleScene.currentScene
    moduleScene.currentScene = talkLoganJulie
end

local function loganRun(logan)
    logan:move(logan.x,900)
end

local buttons = {}
local items_collide = {}
local items_noCollide = {}
local items_interact = {}
local characters = {}

local spriteGrange = love.graphics.newImage("grange.png")
local spriteLogan = love.graphics.newImage("Logan_no_move.png")
local spriteVacheOne = love.graphics.newImage("vache_miam_one.png")
local spriteGabi = love.graphics.newImage("gabi_big.png")

local me = player:new(600, 1600, {0,1,0}, items_collide, items_interact)
local Gabi = Character:new(730,680,150,200,spriteGabi,1.2,nothing,1,2)
Gabi:load()
local Logan = Character:new(400,1400,100,130,spriteLogan,1.6,talkWithLogan,1,1)
Logan:load()
local VacheOne = Character:new(800,1000,300,150,spriteVacheOne,1,nothing,10,1)
VacheOne:load()
local VacheTwo = Character:new(700,1400,300,150,spriteVacheOne,1,nothing,10,3)
VacheTwo:load()
table.insert(characters,Logan)
local camera = Camera:new(me.x,me.y)

-------- Les murs
local wallone = Item:new(100, 600, 100, 1200,{0.6,0.8,0.5})
local walltwo = Item:new(100, 600, 1200, 100,{0.6,0.8,0.5})
local walltrois = Item:new(100, 1800, 1200, 100,{0.6,0.8,0.5})
local wallquatre = Item:new(1200, 600, 100, 1200,{0.6,0.8,0.5})
local grange = Item:new(190,300,700,500,{1,1,1},nothing,spriteGrange,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, walltrois)
table.insert(items_collide, wallquatre)
table.insert(items_collide,VacheOne)
table.insert(items_collide,VacheTwo)
table.insert(items_collide,grange)
table.insert(items_collide,Logan)
table.insert(items_collide,Gabi)

table.insert(items_interact,Gabi)
table.insert(items_interact,Logan)

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
    fade:draw()
    camera:unset()
end

return playSceneTwo