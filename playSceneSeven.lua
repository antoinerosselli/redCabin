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

playSceneSeven = {}
playSceneSeven.__index = playSceneSeven

function playSceneSeven:new()
    local o = {}
    setmetatable(o, self)
    return o
end

local items_collide = {}
local items_interact = {}

local spriteTable = love.graphics.newImage("table_no_eat.png")
local spriteSeat = love.graphics.newImage("seat.png")
local spriteCuisine = love.graphics.newImage("lacuisine.png")

local spriteMaria = love.graphics.newImage("Maria.png")
local Maria = Character:new(1700,130,100,160,spriteMaria,1.33,nothing,1,2)
Maria:load()

-------- Les murs
local wallone = Item:new(0, 600, 500, 100,{139/255, 69/255, 19/255})
local walltwo = Item:new(700, 600, 1400, 100,{139/255, 69/255, 19/255})
local wallthree = Item:new(0, 1100, 500, 100,{139/255, 69/255, 19/255})
local wallfour = Item:new(700, 1100, 500, 100,{139/255, 69/255, 19/255})
local wallfive = Item:new(0, 600, 100, 500,{139/255, 69/255, 19/255})
local wallsix = Item:new(1100, 600, 100, 500,{139/255, 69/255, 19/255})
local wallseven = Item:new(1300, 200, 100, 400,{139/255, 69/255, 19/255})
local wallhuit = Item:new(0, -100, 2000, 100,{139/255, 69/255, 19/255})
local wallnine = Item:new(0, -100, 100, 800,{139/255, 69/255, 19/255})
local wallten = Item:new(2000, -100, 100, 700,{139/255, 69/255, 19/255})
local table_no_eat = Item:new(400, 180, 600, 200,{1,1,1},nothing,spriteTable,1)
local cuisine = Item:new(1400, 420, 600, 80,{1,1,1},nothing,spriteCuisine,1)

local seat_one = Item:new(450, 350, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_two = Item:new(660, 350, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_three = Item:new(870, 350, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_four = Item:new(290, 240, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_five = Item:new(1010, 240, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_six = Item:new(450, 135, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_seven = Item:new(660, 135, 100, 100,{1,1,1},nothing,spriteSeat,1)
local seat_eight = Item:new(870, 135, 100, 100,{1,1,1},nothing,spriteSeat,1)

table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, wallthree)
table.insert(items_collide, wallfour)
table.insert(items_collide, wallfive)
table.insert(items_collide, wallsix)
table.insert(items_collide, wallseven)
table.insert(items_collide, wallhuit)
table.insert(items_collide, wallnine)
table.insert(items_collide, wallten)
table.insert(items_collide, Maria)
table.insert(items_collide,cuisine)

table.insert(items_collide,seat_six)
table.insert(items_collide,seat_seven)
table.insert(items_collide,seat_eight)

table.insert(items_collide,table_no_eat)

table.insert(items_collide,seat_one)
table.insert(items_collide,seat_two)
table.insert(items_collide,seat_three)
table.insert(items_collide,seat_four)
table.insert(items_collide,seat_five)

table.insert(items_interact,Maria)

local me = player:new(100, 400, {0,1,0}, items_collide, items_interact)
local camera = Camera:new(me.x,me.y)
local fade = Fade:new(0.2,2)

function playSceneSeven:load()
    me:spawn()
    fade:reset(1)
    moduleScene.PlayScene = moduleScene.currentScene
end

function playSceneSeven:update(dt)
    moduleSave:Save("playSceneSeven")
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

function playSceneSeven:draw()
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

return playSceneSeven