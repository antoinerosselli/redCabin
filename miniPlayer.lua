local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local miniPlayer = {}

function miniPlayer:new(x, y, color, list_collide,list_interact)
    local object = {
        spawnx = x,
        spawny = y,
        x = x,
        y = y,
        width = 20,
        height = 20,
        color = color,
        speed = 250,
        list_collide = list_collide,
        list_interact = list_interact,
        interact = false,
        move = 'none'
    }
    setmetatable(object, {__index = miniPlayer})
    return object
end

local currentFrame_no_move = 0
local currentFrame_move_up = 0
local frameTimer = 0
local frameDuration = 0.5


function miniPlayer:update(dt)
    local canMove = true
     self.interact = false
     self.move = 'none'
    for i,v in ipairs(self.list_collide) do
        if self:checkCollision(self.x, self.y, self.width, self.height, v.x, v.y, v.width, v.height) then
            canMove = false
        end
    end
    frameTimer = frameTimer + dt
    if frameTimer >= frameDuration then
      currentFrame_no_move = currentFrame_no_move + 1
      currentFrame_move_up = currentFrame_move_up + 1
      frameTimer = 0
      if currentFrame_no_move > 2 then
            currentFrame_no_move = 0 
      end
      if currentFrame_move_up > 1 then
            currentFrame_move_up = 0     
    end 
    end

    if canMove and love.keyboard.isDown(moduleParam.charac_down) then
        for i,v in ipairs(self.list_collide) do
            if self:checkCollision(self.x, self.y + self.speed * dt, self.width, self.height, v.x, v.y, v.width, v.height) then
                canMove = false
            end
        end    
        if canMove == true then
            self.y = self.y + self.speed * dt
        end
        self.move = 'down'
    end

    if canMove and love.keyboard.isDown(moduleParam.charac_left) then
        for i,v in ipairs(self.list_collide) do
            if self:checkCollision(self.x - self.speed * dt, self.y, self.width, self.height, v.x, v.y, v.width, v.height) then
                canMove = false
            end
        end    
        if canMove == true then
            self.x = self.x - self.speed * dt
        end
        self.move = 'left'
    end

    if canMove and love.keyboard.isDown(moduleParam.charac_right) then
        for i,v in ipairs(self.list_collide) do
            if self:checkCollision(self.x + self.speed * dt, self.y, self.width, self.height, v.x, v.y, v.width, v.height) then
                canMove = false
            end
        end    
        if canMove == true then
            self.x = self.x + self.speed * dt
        end
        self.move = 'right'
    end

    if canMove and love.keyboard.isDown(moduleParam.charac_up) then
        for i,v in ipairs(self.list_collide) do
            if self:checkCollision(self.x, self.y - self.speed * dt, self.width, self.height, v.x, v.y, v.width, v.height) then
                canMove = false
            end
        end    
        if canMove == true then
            self.y = self.y - self.speed * dt
        end
        self.move = 'up'
    end

    for i,v in ipairs(self.list_interact) do
        if self:checkCollision(self.x, self.y, self.width, self.height, v.x - 20, v.y - 20, v.width + 40, v.height + 40) then
            self.interact = true
            if love.keyboard.isDown(moduleParam.charac_interaction) and self.interact == true then
                self:interaction(v)
            end    
        end
    end

end

function miniPlayer:checkCollision(x,y,width,height,vx,vy,vwidth,vheight)
        local miniPlayerLeft = x
        local miniPlayerTop = y
        local miniPlayerRight = x + width
        local miniPlayerBottom = y + height
        local itemLeft = vx
        local itemTop = vy
        local itemRight = vx + vwidth
        local itemBottom = vy + vheight
        if miniPlayerRight > itemLeft and
            miniPlayerLeft < itemRight and
            miniPlayerBottom > itemTop and
            miniPlayerTop < itemBottom then
            return true
        else
            return false
        end    
end

function miniPlayer:spawn()
    if moduleScene.needSpawn == true then
        self.x = self.spawnx
        self.y = self.spawny    
    end
    moduleScene.needSpawn = false
end

function miniPlayer:draw()
    love.graphics.setColor({1,0,0})
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1)   
    
    if self.interact == true then
        love.graphics.setColor({0,0,0})
        love.graphics.rectangle("fill", self.x + 25 , self.y - 160, self.width / 2, self.height / 2) 
        love.graphics.setColor({1,1,0})
        love.graphics.rectangle("line", self.x + 25, self.y - 160, self.width / 2, self.height / 2) 
        love.graphics.setColor({1,1,1})
        local font = love.graphics.newFont(20) 
        love.graphics.setFont(font)      
        love.graphics.printf(moduleParam.charac_interaction, self.x + 45, self.y - 150, 30, "left")
    end
end


return miniPlayer