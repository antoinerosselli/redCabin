local Button = require('button')
local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")

DocumentScene = {}
DocumentScene.__index = DocumentScene

function DocumentScene:new(author,text,destina)
    local o = {}
    setmetatable(o, self)
    o.author = author
    o.text = text
    o.destina = destina
    return o
end

function DocumentScene:load()
    
end

local buttons = {}

local function goBack()
    moduleScene.needSpawn = false
    moduleScene.currentScene = moduleScene.oldScene
end

local buttonBack = Button:new(moduleParam.window_Width / 2 - 350, moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "back",{1, 1, 1},goBack) -- bouton bleu avec texte "Bouton bleu"

table.insert(buttons,buttonBack)

function DocumentScene:update(dt)
    for _, button in ipairs(buttons) do
        button:update()
    end
    
end

function DocumentScene:draw()
    local font = love.graphics.newFont(25) 
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.rectangle("line", moduleParam.window_Width / 2 - 400 , 100 , 800 , moduleParam.window_Height  - 100)
    love.graphics.printf(self.destina, moduleParam.window_Width / 2 - 400, moduleParam.window_Height / 2 - 200, 700, "center" )  
    love.graphics.printf(self.text, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 - 100, 700, "left" )  
    love.graphics.printf(self.author, moduleParam.window_Width / 2 + 100, moduleParam.window_Height / 2 + 100, 200, "right" )  
    -- Back
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return DocumentScene