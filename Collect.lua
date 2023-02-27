local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local Collect = {}
Collect.__index = Collect

function Collect:new(x,y,width,height,color,callbacks,sprite,scale)
    local o = {}
    setmetatable(o, self)
    o.x = self.random(self)
    o.y = y
    o.width = width
    o.height = height
    o.color = color
    o.callback = callbacks or 'n/a'
    o.sprite = sprite or 'n/a'
    o.scale = scale or 1
    return o
end

function Collect:callback()
    if  self.callback == 'n/a' then
    else
        self.callback(self)
    end
end

function Collect:random()
    math.randomseed(os.time()) -- initialise la graine aléatoire avec l'heure actuelle
    local randomNumber = math.random(moduleParam.window_Width / 2 - 190, moduleParam.window_Width / 2 + 190) -- génère un nombre aléatoire entre 1 et 100
    return randomNumber
end

function Collect:respawn()
    self.y = moduleParam.window_Height / 2 - 200
    self.x = self.random(self)
end

function Collect:update(dt)
    self.y = self.y + 100 * dt
    if self.y >= moduleParam.window_Height / 2 + 190 then
        self.y = moduleParam.window_Height / 2 - 200
        self.x = self.random(self)
    end
end

function Collect:draw()
    if self.sprite == 'n/a' then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
        love.graphics.setColor(1,1,1)   
    else
        love.graphics.draw(self.sprite, self.x, self.y,0,self.scale,self.scale)
    end
end

return Collect