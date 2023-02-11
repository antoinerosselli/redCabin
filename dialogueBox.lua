local DialogueBox = {}
local moduleScene = require('moduleScene')
local moduleTalk = require('moduleTalk')
DialogueBox.__index = DialogueBox

function DialogueBox:new(text, textColor, boxColor)
    local o = {}
    setmetatable(o, self)
    local window_Width, window_Height = love.window.getDesktopDimensions()
    o.text = text
    o.textColor = textColor
    o.boxColor = boxColor
    o.width = window_Width
    o.height = window_Height / 6
    o.x = 0
    o.y = window_Height / 1.2
    o.currentText = 1
    o.clicked = false
    return o
end

function DialogueBox:update(activation)
    -- Stocker l'état précédent du bouton
    local previousState = self.clicked
    -- Vérifier si le bouton est enfoncé
    self.clicked = love.mouse.isDown(1) and self:isMouseOver()
    -- Si le bouton est enfoncé et qu'il n'était pas enfoncé lors du dernier update
    if self.clicked and not previousState then
        self.currentText = self.currentText + 1
        if moduleTalk.whoTalk == 1 then
            moduleTalk.whoTalk = 2
        else
            moduleTalk.whoTalk = 1
        end    
        if self.currentText > #self.text then
            self.currentText = 1
        end
    end
    if  self.text[self.currentText] == "" then
        if activation == nil then
            moduleScene.currentScene = moduleScene.PlayScene
        else
            activation()
        end
    end
end

function DialogueBox:draw()
    love.graphics.setColor(self.boxColor)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(self.textColor)
    love.graphics.printf(self.text[self.currentText], self.x + 20, self.y + self.height / 2 - 65, self.width - 50, "left")
end

function DialogueBox:isMouseOver()
    local mouseX, mouseY = love.mouse.getPosition()
    return mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
end

return DialogueBox