local Button = require('button')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local moduleSave = require("moduleSave")
local createNewGame = require("createNewGame")

MenuScene = {}
MenuScene.__index = MenuScene

function MenuScene:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function MenuScene:load()
    moduleScene.needSpawn = true
end

-- Chargement de l'image de sprite sheet
local spriteSheet = love.graphics.newImage("img/ble_menu.png")
local la_cabane = love.graphics.newImage("img/la_cabane.png")

-- Création de quads pour chaque sprite
local spriteWidth, spriteHeight = 300, 300
local quads = {}

local currentFrame = 0
local frameTimer = 0
local endFrame = 4
local frameDuration = 1 -- Durée d'une frame en secondes
local spriteWidth, spriteHeight = 300, 300
local window_Width, window_Height = love.window.getDesktopDimensions()

-- Découper le sprite sheet en quads (rectangles) pour chaque frame
for i = 0, 4 do
  quads[i] = love.graphics.newQuad(i * spriteWidth, 0, spriteWidth, spriteHeight, spriteSheet:getDimensions())
end


local function quit()
    profile.stop()
    print(profile.report(20))
    love.event.quit()
end


local function continue()
    if moduleSave:continue() == "playScene" then
        moduleScene.currentScene = playScene
    end 
    if moduleSave:continue() == "playSceneTwo" then
        moduleScene.currentScene = playSceneTwo
    end 
    if moduleSave:continue() == "playSceneThree" then
        moduleScene.currentScene = playSceneThree
    end 
    if moduleSave:continue() == "playSceneFour" then
        moduleScene.currentScene = playSceneFour
    end 
    if moduleSave:continue() == "playSceneFive" then
        moduleScene.currentScene = playSceneFive
    end 
    if moduleSave:continue() == "playSceneSix" then
        moduleScene.currentScene = playSceneSix
    end 
    if moduleSave:continue() == "playSceneSeven" then
        moduleScene.currentScene = playSceneSeven
    end 
    if moduleSave:continue() == "playSceneEight" then
        moduleScene.currentScene = playSceneEight
    end 
    if moduleSave:continue() == "playSceneNine" then
        moduleScene.currentScene = playSceneNine
    end 
end

local function changetoSettings()
    moduleScene.oldScene = MenuScene
    moduleScene.currentScene = ParamScene
end

local function  openPopup()
    moduleScene.currentScene = createNewGame
end

local buttons = {}
local posEntry = moduleParam.window_Height / 3
local buttonContinue = Button:new(moduleParam.window_Width - 250, posEntry , 200, 100, {0, 0, 0}, "Continuer",{1, 1, 1}, continue) 
local buttonNew = Button:new(moduleParam.window_Width - 250, posEntry + 120, 200, 100, {0, 0, 0}, "Nouvelle partie",{1, 1, 1}, openPopup) 
local buttonSettings = Button:new(moduleParam.window_Width - 250, posEntry + 240, 200, 100, {0, 0, 0}, "Paramètres",{1, 1, 1}, changetoSettings) 
local buttonQuit = Button:new(moduleParam.window_Width - 250, posEntry + 360, 200, 100, {0, 0, 0}, "Quitter",{1, 1, 1}, quit) 
local tilte = love.graphics.newImage("img/title.png")
table.insert(buttons, buttonContinue)
table.insert(buttons, buttonNew)
table.insert(buttons, buttonSettings)
table.insert(buttons, buttonQuit)
local go = true

function MenuScene:update(dt)
    for _, button in ipairs(buttons) do
        button:update()
    end
    frameTimer = frameTimer + dt
    if frameTimer >= frameDuration and go == true then
      currentFrame = currentFrame + 1
      frameTimer = 0
      if currentFrame == 3 then
            go = false
        end
    end
    if frameTimer >= frameDuration and go == false then
        currentFrame = currentFrame - 1
        frameTimer = 0
        if currentFrame == 1 then
              go = true
          end
      end  
      if love.keyboard.isDown("t") then
        moduleScene.currentScene = sceneTestMenu
    end
end

function MenuScene:draw()
    love.graphics.setColor(0.1,0.13,0)
    love.graphics.rectangle("fill", 0 , moduleParam.window_Height - 500 , moduleParam.window_Width - 700 , 150)
    love.graphics.setColor(0.2,0.25,0.05)
    love.graphics.rectangle("fill", 0 , moduleParam.window_Height - 400 , moduleParam.window_Width - 600 , 150)
    love.graphics.setColor(0.2,0.3,0.1)
    love.graphics.rectangle("fill", 0 , moduleParam.window_Height - 300 , moduleParam.window_Width - 500 , 150)
    love.graphics.setColor(0.3,0.4,0.2)
    love.graphics.rectangle("fill", 0 , moduleParam.window_Height - 200 , moduleParam.window_Width - 400 , 150)
    love.graphics.setColor(0.4,0.5,0.3)
    love.graphics.rectangle("fill", 0 , moduleParam.window_Height - 100 , moduleParam.window_Width - 300 , 150)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(la_cabane, 200,moduleParam.window_Height - 700, 0, 1, 1)
    love.graphics.draw(tilte,moduleParam.window_Width / 2 , 50,0,1,1)
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return MenuScene