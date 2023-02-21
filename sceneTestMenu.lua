local Button = require('button')
local menuScene = require('menuScene')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")

sceneTestMenu = {}
sceneTestMenu.__index = sceneTestMenu

function sceneTestMenu:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function sceneTestMenu:load()
    
end

local buttons = {}

local function goBack()
    moduleScene.currentScene = menuScene
end

local function goScene1()
    moduleScene.currentScene = playScene
end
local function goScene2()
    moduleScene.currentScene = playSceneTwo
end
local function goScene3()
    moduleScene.currentScene = playSceneThree
end
local function goScene4()
    moduleScene.currentScene = playSceneFour
end
local function goScene5()
    moduleScene.currentScene = playSceneFive
end
local function goScene6()
    moduleScene.currentScene = playSceneSix
end
local function goScene7()
    moduleScene.currentScene = playSceneSeven
end
local function goSceneShadow()
    moduleScene.currentScene = playSceneShadow
end
local function goSceneGame()
    moduleScene.currentScene = gameCollectMemo
end

local buttonBack = Button:new(moduleParam.window_Width / 2 - 100,moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "back",{1, 1, 1},goBack) 
local buttonScene1 = Button:new(300, 200 , 200, 100, {0, 0, 0}, "Scene 1",{1, 1, 1},goScene1) 
local buttonScene2 = Button:new(600, 200 , 200, 100, {0, 0, 0}, "Scene 2",{1, 1, 1},goScene2) 
local buttonScene3 = Button:new(900, 200 , 200, 100, {0, 0, 0}, "Scene 3",{1, 1, 1},goScene3) 
local buttonScene4 = Button:new(300, 400 , 200, 100, {0, 0, 0}, "Scene 4",{1, 1, 1},goScene4) 
local buttonScene5 = Button:new(600, 400 , 200, 100, {0, 0, 0}, "Scene 5",{1, 1, 1},goScene5) 
local buttonScene6 = Button:new(900, 400 , 200, 100, {0, 0, 0}, "Scene 6",{1, 1, 1},goScene6) 
local buttonScene7 = Button:new(300, 600 , 200, 100, {0, 0, 0}, "Scene 7",{1, 1, 1},goScene7) 
local buttonSceneShadow = Button:new(600, 600 , 200, 100, {0, 0, 0}, "Scene Shadow",{1, 1, 1},goSceneShadow) 
local buttonSceneGame = Button:new(900, 600 , 200, 100, {0, 0, 0}, "Scene Memo",{1, 1, 1},goSceneGame) 
table.insert(buttons,buttonBack)
table.insert(buttons,buttonScene1)    
table.insert(buttons,buttonScene2)    
table.insert(buttons,buttonScene3)    
table.insert(buttons,buttonScene4)    
table.insert(buttons,buttonScene5)    
table.insert(buttons,buttonScene6)   
table.insert(buttons,buttonScene7)
table.insert(buttons,buttonSceneShadow)    
table.insert(buttons,buttonSceneGame)    

function sceneTestMenu:update(dt)
    for _, button in ipairs(buttons) do
        button:update()
    end
end

function sceneTestMenu:draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return sceneTestMenu