local Button = require('button')
local Fade = require('fade')
local Item = require('Item')
local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local moduleSave = require("module/moduleSave")
local miniPlayer = require('miniPlayer')
local Collect = require('Collect')

gameCollectMemo = {}
gameCollectMemo.__index = gameCollectMemo

function gameCollectMemo:new(words,sprite)
    local o = {
    }
    setmetatable(o, self)
    o.coco = Collect:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200, 10, 10,{0, 1, 0},nothing, sprite,1)
    o.me = nil
    o.fade = nil
    o.words = words
    return o
end

local buttons = {}
local items_collide = {}
local items_interact = {}

function gameCollectMemo:load()
    self.fade = Fade:new(0.2,2)
    self.me = miniPlayer:new(moduleParam.window_Width / 2 , moduleParam.window_Height / 2 , {1,0,0}, items_collide, items_interact)
    self.me:spawn()
    table.insert(items_interact, self.coco)
    self.fade:reset(1)
end


local function wakeup()
    moduleScene.currentScene = moduleScene.PlayScene
end

local buttonContinue = Button:new(moduleParam.window_Width / 2 - 100, moduleParam.window_Height - 250  , 200, 100, {0, 0, 0}, "réveil",{1, 1, 1}, wakeup) 

table.insert(buttons, buttonContinue)
-------- Les murs
local wallone = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200, 10, 400,{138/250, 43/250, 226/250})
local walltwo = Item:new(moduleParam.window_Width / 2 + 200, moduleParam.window_Height / 2 - 200, 10, 400,{138/250, 43/250, 226/250})
local wallthree = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200, 400, 10,{138/250, 43/250, 226/250})
local wallfour = Item:new(moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 + 190, 400, 10,{138/250, 43/250, 226/250})


table.insert(items_collide, wallone)
table.insert(items_collide, walltwo)
table.insert(items_collide, wallthree)
table.insert(items_collide, wallfour)

local timer = 0

local function nextwords(x, s)
    -- Divise la phrase en un tableau de mots
    local mots = {}
    for mot in s:gmatch("%S+") do
        table.insert(mots, mot)
    end

    -- Concatène les x premiers mots de la phrase dans une chaîne de caractères
    local resultat = ""
    for i = 1, math.min(x, #mots) do
        resultat = resultat .. mots[i] .. " "
    end

    return resultat
end

local function hmw(s)
     -- Divise la phrase en un tableau de mots
    local mots = {}
    for mot in s:gmatch("%S+") do
         table.insert(mots, mot)
     end
    
        -- Retourne le nombre de mots dans la phrase
        return #mots    
end


function gameCollectMemo:update(dt)
    self.fade:update(dt)
    for _, item in ipairs(items_collide) do
        item:update(dt)
    end
    for _, item in ipairs(items_interact) do
        item:update(dt)
    end
    self.me:update(dt)
    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end
    if self.me.score >= hmw(self.words) then
        for _, item in ipairs(buttons) do
            item:update(dt)
        end    
    end

end

function gameCollectMemo:draw()
    for _, item in ipairs(items_collide) do
        item:draw()
    end
    for _, item in ipairs(items_interact) do
        item:draw()
    end
    self.me:draw()
    if moduleScene.fadeOk == true then
        self.fade:draw()
    end
    love.graphics.setColor({1,1,1})
    love.graphics.printf(nextwords(self.me.score,self.words), moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200,400, "left")
    if self.me.score >= hmw(self.words) then
        love.graphics.setColor({0,0,0})
        love.graphics.rectangle("fill",0,0,3000,3000)
        love.graphics.setColor({1,0,0})
        love.graphics.printf(self.words, moduleParam.window_Width / 2 - 200, moduleParam.window_Height / 2 - 200,400, "left")    
        for _, item in ipairs(buttons) do
            item:draw()
        end    
    end

end

return gameCollectMemo