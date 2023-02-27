local Button = require('button')
local moduleScene = require('module/moduleScene')
local moduleParam = require("module/moduleParam")
local keyScene = require("keyScene")
local moduleSave = require("module/moduleSave")
local player = require('player')
local Camera = require("camera")
local gpMemberScene = require("gpMemberScene")
local CineScene = require("cineScene")

changeCommandScene = {}
changeCommandScene.__index = changeCommandScene

function changeCommandScene:new()
    local o = {}
    setmetatable(o, self)
    o.input = nil
    return o
end

function detectInput(basic)
    if love.keyboard.isDown("a") then
        return "a"
    elseif love.keyboard.isDown("z") then
        return "z"
    elseif love.keyboard.isDown("e") then
        return "e"
    elseif love.keyboard.isDown("r") then
        return "r"
    elseif love.keyboard.isDown("t") then
        return "t"
    elseif love.keyboard.isDown("y") then
        return "y"
    elseif love.keyboard.isDown("u") then
        return "u"
    elseif love.keyboard.isDown("i") then
        return "i"
    elseif love.keyboard.isDown("o") then
        return "o"
    elseif love.keyboard.isDown("p") then
        return "p"
    elseif love.keyboard.isDown("q") then
        return "q"
    elseif love.keyboard.isDown("s") then
        return "s"
    elseif love.keyboard.isDown("d") then
        return "d"
    elseif love.keyboard.isDown("f") then
        return "f"
    elseif love.keyboard.isDown("g") then
        return "g"
    elseif love.keyboard.isDown("h") then
        return "h"
    elseif love.keyboard.isDown("j") then
        return "j"
    elseif love.keyboard.isDown("k") then
        return "k"
    elseif love.keyboard.isDown("l") then
        return "l"
    elseif love.keyboard.isDown("m") then
        return "m"
    elseif love.keyboard.isDown("w") then
        return "w"
    elseif love.keyboard.isDown("x") then
        return "x"
    elseif love.keyboard.isDown("c") then
        return "c"
    elseif love.keyboard.isDown("v") then
        return "v"
    elseif love.keyboard.isDown("b") then
        return "b"
    elseif love.keyboard.isDown("n") then
        return "n"
    else
        return basic
    end      
end

function changeKeyUp()
    local changeKeyScene = keyScene:new("up")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyDown()
    local changeKeyScene = keyScene:new("down")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyLeft()
    local changeKeyScene = keyScene:new("left")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyRight()
    local changeKeyScene = keyScene:new("right")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyInteract()
    local changeKeyScene = keyScene:new("interact")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyUpHL()
    local changeKeyScene = keyScene:new("hlup")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyDownHL()
    local changeKeyScene = keyScene:new("hldown")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyLeftHL()
    local changeKeyScene = keyScene:new("hlleft")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyRightHL()
    local changeKeyScene = keyScene:new("hlright")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyInteractHL()
    local changeKeyScene = keyScene:new("hlinteract")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyUpHR()
    local changeKeyScene = keyScene:new("hRup")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyDownHR()
    local changeKeyScene = keyScene:new("hRdown")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyLeftHR()
    local changeKeyScene = keyScene:new("hRleft")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyRightHR()
    local changeKeyScene = keyScene:new("hRright")
    moduleScene.currentScene = changeKeyScene
end

function changeKeyInteractHR()
    local changeKeyScene = keyScene:new("hRinteract")
    moduleScene.currentScene = changeKeyScene
end

local function back()
    moduleParam:setParam()
    moduleScene.currentScene = ParamScene
end

local function reset()
    moduleParam:resetParam()
    love:load()
end

local width,height = love.window.getDesktopDimensions()

local buttons = {}
local buttonRetour = Button:new(moduleParam.window_Width / 2 + 200, moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "Save",{1, 1, 1}, back) 
local buttonreset = Button:new(moduleParam.window_Width / 2 - 400, moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "Reset",{1, 1, 1}, reset) 
table.insert(buttons,buttonRetour)
table.insert(buttons,buttonreset)

function changeCommandScene:load()
    local button_up = Button:new(width / 2 - 300, height - height + 170 , 100, 80, {0, 0, 0}, moduleParam.charac_up,{1, 1, 1},changeKeyUp) -- bouton bleu avec texte "Bouton bleu"
    local button_down = Button:new(width / 2 - 300 ,height - height + 270 , 100, 80, {0, 0, 0}, moduleParam.charac_down,{1, 1, 1},changeKeyDown) -- bouton bleu avec texte "Bouton bleu"
    local button_left = Button:new(width / 2 - 300 ,height - height + 370 , 100, 80, {0, 0, 0}, moduleParam.charac_left,{1, 1, 1},changeKeyLeft) -- bouton bleu avec texte "Bouton bleu"
    local button_right = Button:new(width / 2 - 300 ,height - height + 470 , 100, 80, {0, 0, 0}, moduleParam.charac_right,{1, 1, 1},changeKeyRight) -- bouton bleu avec texte "Bouton bleu"
    local button_interaction = Button:new(width / 2 - 300 ,height - height + 570 , 100, 80, {0, 0, 0}, moduleParam.charac_interaction,{1, 1, 1},changeKeyInteract) -- bouton bleu avec texte "Bouton bleu"

    local buttonHL_up = Button:new(width / 2 + 100 , height - height + 170 , 100, 80, {0, 0, 0}, moduleParam.handL_up,{1, 1, 1},changeKeyUpHL) -- bouton bleu avec texte "Bouton bleu"
    local buttonHL_down = Button:new(width / 2 + 100 ,height - height + 270 , 100, 80, {0, 0, 0}, moduleParam.handL_down,{1, 1, 1},changeKeyDownHL) -- bouton bleu avec texte "Bouton bleu"
    local buttonHL_left = Button:new(width / 2 + 100 ,height - height + 370 , 100, 80, {0, 0, 0}, moduleParam.handL_left,{1, 1, 1},changeKeyLeftHL) -- bouton bleu avec texte "Bouton bleu"
    local buttonHL_right = Button:new(width / 2 + 100 ,height - height + 470 , 100, 80, {0, 0, 0}, moduleParam.handL_right,{1, 1, 1},changeKeyRightHL) -- bouton bleu avec texte "Bouton bleu"
    local buttonHL_interaction = Button:new(width / 2 + 100 ,height - height + 570 , 100, 80, {0, 0, 0}, moduleParam.handL_interaction,{1, 1, 1},changeKeyInteractHL) -- bouton bleu avec texte "Bouton bleu"

    local buttonHR_up = Button:new(width / 2 + 500 , height - height + 170 , 100, 80, {0, 0, 0}, moduleParam.handR_up,{1, 1, 1},changeKeyUpHR) -- bouton bleu avec texte "Bouton bleu"
    local buttonHR_down = Button:new(width / 2 + 500 ,height - height + 270 , 100, 80, {0, 0, 0}, moduleParam.handR_down,{1, 1, 1},changeKeyDownHR) -- bouton bleu avec texte "Bouton bleu"
    local buttonHR_left = Button:new(width / 2 + 500 ,height - height + 370 , 100, 80, {0, 0, 0}, moduleParam.handR_left,{1, 1, 1},changeKeyLeftHR) -- bouton bleu avec texte "Bouton bleu"
    local buttonHR_right = Button:new(width / 2 + 500 ,height - height + 470 , 100, 80, {0, 0, 0}, moduleParam.handR_right,{1, 1, 1},changeKeyRightHR) -- bouton bleu avec texte "Bouton bleu"
    local buttonHR_interaction = Button:new(width / 2 + 500 ,height - height + 570 , 100, 80, {0, 0, 0}, moduleParam.handR_interaction,{1, 1, 1},changeKeyInteractHR) -- bouton bleu avec texte "Bouton bleu"


    table.insert(buttons,button_up)
    table.insert(buttons,button_down)
    table.insert(buttons,button_left)
    table.insert(buttons,button_right)
    table.insert(buttons,button_interaction)

    table.insert(buttons,buttonHL_up)
    table.insert(buttons,buttonHL_down)
    table.insert(buttons,buttonHL_left)
    table.insert(buttons,buttonHL_right)
    table.insert(buttons,buttonHL_interaction)

    table.insert(buttons,buttonHR_up)
    table.insert(buttons,buttonHR_down)
    table.insert(buttons,buttonHR_left)
    table.insert(buttons,buttonHR_right)
    table.insert(buttons,buttonHR_interaction)

end

function changeCommandScene:update(dt)
    self.input = detectInput()
    for _, button in ipairs(buttons) do
        button:update(dt)
    end
end

function changeCommandScene:draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
  -- Affichage du texte
  love.graphics.setColor({1,1,1}) -- couleur du texte noir
  local font = love.graphics.newFont(26) 
  love.graphics.setFont(font)
  --- Character
  love.graphics.printf("Character : ", width / 2 - 500, height - height + 100 , 200, "left")
  love.graphics.printf("Move_up : ", width / 2 - 500, height - height + 200 , 200, "left")
  love.graphics.printf("Move_down : ", width / 2 - 500, height - height + 300 , 200, "left")
  love.graphics.printf("Move_left : ", width / 2 - 500, height - height + 400 , 200, "left")
  love.graphics.printf("Move_right : ", width / 2 - 500, height - height + 500 , 200, "left")
  love.graphics.printf("Interaction : ", width / 2 - 500, height - height + 600 , 200, "left")
  --- Hand
  -- Left
  love.graphics.printf("Hand_Left : ", width / 2 - 100, height - height + 100 , 200, "left")
  love.graphics.printf("Move_up : ", width / 2 - 100, height - height + 200 , 200, "left")
  love.graphics.printf("Move_down : ", width / 2 - 100, height - height + 300 , 200, "left")
  love.graphics.printf("Move_left : ", width / 2 - 100, height - height + 400 , 200, "left")
  love.graphics.printf("Move_right : ", width / 2 - 100, height - height + 500 , 200, "left")
  love.graphics.printf("Interaction : ", width / 2 - 100, height - height + 600 , 200, "left")
  -- Right
  love.graphics.printf("Hand_Right : ", width / 2 + 300, height - height + 100 , 200, "left")
  love.graphics.printf("Move_up : ", width / 2 + 300, height - height + 200 , 200, "left")
  love.graphics.printf("Move_down : ", width / 2 + 300, height - height + 300 , 200, "left")
  love.graphics.printf("Move_left : ", width / 2 + 300, height - height + 400 , 200, "left")
  love.graphics.printf("Move_right : ", width / 2 + 300, height - height + 500 , 200, "left")
  love.graphics.printf("Interaction : ", width / 2 + 300, height - height + 600 , 200, "left")
end

return changeCommandScene