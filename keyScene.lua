local moduleParam = require('module/moduleParam')
local Button = require('button')
local moduleScene = require('module/moduleScene')
local moduleSave = require('module/moduleSave')

local keyScene = {}

function keyScene:new(key)
  local keyScene = {
    key = key
  }
  setmetatable(keyScene, self)
  self.__index = self
  return keyScene
end

local function newKey()
    moduleScene.currentScene = changeCommandScene
end

function keyScene:load()
    
end


local buttons = {}
local buttonRetour = Button:new(moduleParam.window_Width / 2 - 100, moduleParam.window_Height / 2 + 150 , 200, 100, {0, 0, 0}, "Modifier",{1, 1, 1}, newKey) 
table.insert(buttons, buttonRetour)

function keyScene:update()
    for _, button in ipairs(buttons) do
        button:update()
    end
    if self.key == "up" then
        moduleParam.charac_up =  detectInput(moduleParam.charac_up)
        love.graphics.printf(moduleParam.charac_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "down"then
        moduleParam.charac_down =  detectInput(moduleParam.charac_down)
        love.graphics.printf(moduleParam.charac_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "left" then
        moduleParam.charac_left =  detectInput(moduleParam.charac_left)
        love.graphics.printf(moduleParam.charac_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "right" then
        moduleParam.charac_right =  detectInput(moduleParam.charac_right)
        love.graphics.printf(moduleParam.charac_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "interact" then
        moduleParam.charac_interaction =  detectInput(moduleParam.charac_interaction)
        love.graphics.printf(moduleParam.charac_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlup" then
        moduleParam.handL_up =  detectInput(moduleParam.handL_up)
        love.graphics.printf(moduleParam.handL_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hldown"then
        moduleParam.handL_down =  detectInput(moduleParam.handL_down)
        love.graphics.printf(moduleParam.handL_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlleft" then
        moduleParam.handL_left =  detectInput(moduleParam.handL_left)
        love.graphics.printf(moduleParam.handL_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlright" then
        moduleParam.handL_right =  detectInput(moduleParam.handL_right)
        love.graphics.printf(moduleParam.handL_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlinteract" then
        moduleParam.handL_interaction =  detectInput(moduleParam.handL_interaction)
        love.graphics.printf(moduleParam.handL_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrup" then
        moduleParam.handR_up =  detectInput(moduleParam.handR_up)
        love.graphics.printf(moduleParam.handR_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrdown"then
        moduleParam.handR_down =  detectInput(moduleParam.handR_down)
        love.graphics.printf(moduleParam.handR_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrleft" then
        moduleParam.handR_left =  detectInput(moduleParam.handR_left)
        love.graphics.printf(moduleParam.handR_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrright" then
        moduleParam.handR_right =  detectInput(moduleParam.handR_right)
        love.graphics.printf(moduleParam.handR_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrinteract" then
        moduleParam.handR_interaction =  detectInput(moduleParam.handR_interaction)
        love.graphics.printf(moduleParam.handR_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
end

function keyScene:draw()
    local font = love.graphics.newFont(25) 
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", moduleParam.window_Width / 2 - 400 , moduleParam.window_Height / 2 - 300 , 800 , 600)
    love.graphics.setFont(font)
    love.graphics.printf("Appuyer sur n'importe quel touche du clavier", moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 - 100, 700, "center" )  
    if self.key == "up"then
        love.graphics.printf(moduleParam.charac_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "down"then
        love.graphics.printf(moduleParam.charac_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "left" then
        love.graphics.printf(moduleParam.charac_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "right" then
        love.graphics.printf(moduleParam.charac_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "interact" then
        love.graphics.printf(moduleParam.charac_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlup"then
        love.graphics.printf(moduleParam.handL_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hldown"then
        love.graphics.printf(moduleParam.handL_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlleft" then
        love.graphics.printf(moduleParam.handl_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlright" then
        love.graphics.printf(moduleParam.handL_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hlinteract" then
        love.graphics.printf(moduleParam.handL_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrup"then
        love.graphics.printf(moduleParam.handR_up, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrdown"then
        love.graphics.printf(moduleParam.handR_down, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrleft" then
        love.graphics.printf(moduleParam.handR_left, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrright" then
        love.graphics.printf(moduleParam.handR_right, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    if self.key == "hrinteract" then
        love.graphics.printf(moduleParam.handR_interaction, moduleParam.window_Width / 2 - 350, moduleParam.window_Height / 2 + 50, 700, "center" )  
    end
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

return keyScene