-- Définition de la classe Button
local Button = require('button')
local menuScene = require('menuScene')
local CineScene = require('cineScene')
local keyScene = require("keyScene")
local paramScene = require('paramScene')
local documentScene = require('documentScene')
local gameplayMember = require('gpMemberScene')
local playScene = require('playScene')
local playSceneTwo = require('playScenetwo')
local pauseScene = require('pauseScene')
local talkScene = require('talkScene')
local changeCommandScene = require('changeCommandScene')
local Player = require('player')
local moduleScene = require('module/moduleScene')
local moduleParam = require('module/moduleParam')
local playSceneThree = require('playSceneThree')
local playSceneFour = require('playSceneFour')
local playSceneFive = require('playSceneFive')
local playSceneSix = require('playSceneSix')
local playSceneSeven = require('playSceneSeven')
local playSceneEight = require('playSceneEight')
local playSceneNine = require('playSceneNine')
local playSceneTen = require('playSceneTen')
local playSceneShadow = require('playSceneShadow')
local gameCollectMemo = require('gameCollectMemo')
local sceneTestMenu = require('sceneTestMenu')
local gameCourse = require('gameCourse')
local playSceneInCabin = require('playSceneInCabin')
local playSceneOutCabin = require('playSceneOutCabin')
local gameInTheDark = require('gameInTheDark')
local current_text = 1 
local boxstate = false
local isDragging = false

local menu = menuScene:new()

local cursor = love.mouse.newCursor("img/cursor.png", 0, 0)
local nocursor = love.mouse.newCursor("img/nothing.png", 0, 0)

-- Chargement de l'image de sprite sheet
local introSprite = love.graphics.newImage("img/logodev.png")
local window_Width, window_Height = love.window.getDesktopDimensions()
local introLogo = CineScene:new(introSprite,window_Width / 2 - 150,window_Height / 2 - 150, 3 ,300,300,1, menuScene)

-- Scene
moduleScene.currentScene = introLogo
local currentScene = moduleScene.currentScene
moduleParam.fullScreen = true
--moduleParam:getParam()

function love.load()
    if moduleParam.fullScreen == true then
        love.window.setFullscreen(true)
    else
        love.window.setMode(900,500)
        moduleParam.window_Width = 900
        moduleParam.window_Height = 500
    end    
    currentScene:load()
end  

function love.update(dt)
    if  currentScene == moduleScene.currentScene then
            currentScene:update(dt)
        else
            currentScene = moduleScene.currentScene
            love:load()
    end
end

function love.draw()
    currentScene:draw()
    if moduleScene.cursorPresence == true then
        love.mouse.setCursor(cursor)
    else
        love.mouse.setCursor(nocursor)
    end
end