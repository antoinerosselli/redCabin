local moduleScene = require("moduleScene")
local moduleParam = require("moduleParam")
local Player = {}

function Player:new(x, y, color, list_collide,list_interact)
    local object = {
        spawnx = x,
        spawny = y,
        x = x,
        y = y,
        width = 100,
        height = 100,
        color = color,
        speed = 250,
        list_collide = list_collide,
        list_interact = list_interact,
        interact = false,
        move = 'none'
    }
    setmetatable(object, {__index = Player})
    return object
end

local currentFrame_no_move = 0
local currentFrame_move_up = 0
local frameTimer = 0
local frameDuration = 0.5

--- Skin no move ---
local quads_no_move = {}
local skin_no_move = love.graphics.newImage("img/julie_big.png")
for i = 0, 2 do
    quads_no_move[i] = love.graphics.newQuad(i * 100 , 0, 100, 100, skin_no_move:getDimensions())
end      
--------------------

--- Skin up ---
local quads_move_up = {}
local skin_move_up = love.graphics.newImage("img/julie_big_up.png")
for y = 0, 1 do
    quads_move_up[y] = love.graphics.newQuad(y * 100 , 0, 100, 100, skin_move_up:getDimensions())
end      
---------------

--- Skin up ---
local quads_move_down = {}
local skin_move_down = love.graphics.newImage("img/julie_big_down.png")
for y = 0, 1 do
    quads_move_down[y] = love.graphics.newQuad(y * 100 , 0, 100, 100, skin_move_down:getDimensions())
end      
---------------

--- Skin up ---
local quads_move_left = {}
local skin_move_left = love.graphics.newImage("img/julie_big_left.png")
for y = 0, 1 do
    quads_move_left[y] = love.graphics.newQuad(y * 100 , 0, 100, 100, skin_move_left:getDimensions())
end      
---------------

function Player:update(dt)
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

function Player:checkCollision(x,y,width,height,vx,vy,vwidth,vheight)
        local playerLeft = x
        local playerTop = y
        local playerRight = x + width
        local playerBottom = y + height
        local itemLeft = vx
        local itemTop = vy
        local itemRight = vx + vwidth
        local itemBottom = vy + vheight
        if playerRight > itemLeft and
            playerLeft < itemRight and
            playerBottom > itemTop and
            playerTop < itemBottom then
            return true
        else
            return false
        end    
end

function Player:spawn()
    if moduleScene.needSpawn == true then
        self.x = self.spawnx
        self.y = self.spawny    
    end
    moduleScene.needSpawn = false
end

function Player:draw()
    if self.move == 'up' then
        -- UP MOVE SKIN --
        love.graphics.draw(skin_move_up, quads_move_up[currentFrame_move_up], self.x - 50 ,self.y - 100, 0, 2,2 )
        ------------------
    elseif self.move == "left" then
        -- LEFT MOVE SKIN --
        love.graphics.draw(skin_move_left, quads_move_left[currentFrame_move_up], self.x - 50 ,self.y - 100, 0, 2,2 )
        --------------------                
    elseif self.move == 'down' or self.move == 'right' then
         -- DOWN MOVE SKIN --
        love.graphics.draw(skin_move_down, quads_move_down[currentFrame_move_up], self.x - 50 ,self.y - 100, 0, 2,2 )
         --------------------        
    else
        -- NO MOVE SKIN --
        love.graphics.draw(skin_no_move, quads_no_move[currentFrame_no_move], self.x - 50 ,self.y - 100, 0, 2,2 )
        -----------------
    end
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

function Player:interaction(item)
    if item.callback == 'n/a' then
    else
        item:callback()
    end
end

return Player