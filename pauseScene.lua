local Button = require('button')
local moduleScene = require("module/moduleScene")

PauseScene = {}
PauseScene.__index = PauseScene

function PauseScene:new(oldscene)
    local o = {}
    setmetatable(o, self)
    o.oldscene = oldscene
    return o
end

function PauseScene:load()
    
end

local buttons = {}

local function goBack()
    moduleScene.currentScene = moduleScene.oldScene
end

local function goMenu()
    moduleScene.currentScene = MenuScene
end

local window_Width, window_Height = love.window.getDesktopDimensions()
local buttonBack = Button:new(window_Width / 2 - 100, window_Height / 2 + 150 , 200, 100, {0, 0, 0}, "back",{1, 1, 1},goBack) -- bouton bleu avec texte "Bouton bleu"
local buttonMenu = Button:new(window_Width / 2 - 100, window_Height / 2 , 200, 100, {0, 0, 0}, "retour menu",{1, 1, 1},goMenu) -- bouton bleu avec texte "Bouton bleu"

table.insert(buttons,buttonBack)
table.insert(buttons,buttonMenu)

function PauseScene:update(dt)
    for _, button in ipairs(buttons) do
        button:update()
    end
    
end

function PauseScene:draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return PauseScene