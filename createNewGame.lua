local moduleParam = require('moduleParam')
local cineScene = require("cineScene")
local Button = require('button')
local moduleScene = require('moduleScene')
local moduleSave = require('moduleSave')
local createNewGame = {}

function createNewGame:new()
  local createNewGame = {}
  setmetatable(createNewGame, self)
  self.__index = self
  return createNewGame
end

local function newGame()
    moduleSave:newGame()
    local hell_door = love.graphics.newImage("img/hell_door.png")
    local the_door = cineScene:new(hell_door,moduleParam.window_Width / 2 - 250 , moduleParam.window_Height / 2 - 350,0.4,500,700,30,playScene,1)
    moduleScene.currentScene = the_door
end

function createNewGame:load()
    
end

local function back()
    moduleScene.currentScene = MenuScene
end

local buttons = {}
local buttonNewGame = Button:new(moduleParam.window_Width / 2 - 250, moduleParam.window_Height / 2 + 150 , 200, 100, {0, 0, 0}, "Annuler",{1, 1, 1}, back) 
local buttonRetour = Button:new(moduleParam.window_Width / 2 + 50, moduleParam.window_Height / 2 + 150 , 200, 100, {0, 0, 0}, "Continuer",{1, 1, 1}, newGame) 
table.insert(buttons, buttonNewGame)
table.insert(buttons, buttonRetour)

function createNewGame:update()
    for _, button in ipairs(buttons) do
        button:update()
    end
end

function createNewGame:draw()
    local font = love.graphics.newFont(25) 
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", moduleParam.window_Width / 2 - 400 , moduleParam.window_Height / 2 - 300 , 800 , 600)
    love.graphics.setFont(font)
    love.graphics.printf("Voulez-vous vraiment commencer une nouvelle partie ? ", moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 - 100, 700, "center" )  
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return createNewGame