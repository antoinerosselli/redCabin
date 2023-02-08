local Button = require('button')
local menuScene = require('menuScene')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")

ParamScene = {}
ParamScene.__index = ParamScene

function ParamScene:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function ParamScene:load()
    
end

local buttons = {}

local function goBack()
    moduleScene.currentScene = menuScene
end

local function goChangeCommand()
    moduleScene.currentScene = changeCommandScene
end

local buttonBack = Button:new(moduleParam.window_Width / 2 - 100,moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "back",{1, 1, 1},goBack) 
local buttonChangeCommand = Button:new(300, 200 , 200, 100, {0, 0, 0}, "Commande",{1, 1, 1},goChangeCommand) 
table.insert(buttons,buttonBack)
table.insert(buttons,buttonChangeCommand)    

function ParamScene:update(dt)
    for _, button in ipairs(buttons) do
        button:update()
    end
end

function ParamScene:draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return ParamScene