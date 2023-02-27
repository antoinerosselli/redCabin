local moduleScene = require("module/moduleScene")
local moduleParam = require("module/moduleParam")
local Button = require("button")
local Member = require("member")

GpMemberScene = {}
GpMemberScene.__index = GpMemberScene

function GpMemberScene:new(list_of_object,list_of_set)
    local o = {}
    setmetatable(o, self)
    o.list_of_object = list_of_object or 'n/a'
    o.list_of_set = list_of_set or 'n/a'
    return o
end


local members = {}
local window_Width, window_Height = love.window.getDesktopDimensions()

local MemberL = Member:new(100, window_Height - 200, 100, 200, "img/hand_left.png","img/hand_left_grab.png", moduleParam.handL_up, moduleParam.handL_down, moduleParam.handL_left, moduleParam.handL_right, moduleParam.handL_interaction)
local MemberR = Member:new(window_Width - 200 , window_Height - 200, 100, 200, "img/hand_right.png","img/hand_right_grab.png",moduleParam.handR_up, moduleParam.handR_down, moduleParam.handR_left, moduleParam.handR_right, moduleParam.handR_interaction)

table.insert(members,MemberL)
table.insert(members,MemberR)

local buttons = {}

local function goBack()
    moduleScene.needSpawn = false
    moduleScene.currentScene = moduleScene.PlayScene
end

local buttonBack = Button:new(moduleParam.window_Width - 250, moduleParam.window_Height - 150 , 200, 100, {0, 0, 0}, "back",{1, 1, 1},goBack) -- bouton bleu avec texte "Bouton bleu"

table.insert(buttons,buttonBack)

function GpMemberScene:load()
    moduleScene.fadeOk = false
    MemberL.x = MemberL.originx
    MemberL.y = MemberL.originy

    MemberR.x = MemberR.originx
    MemberR.y = MemberR.originy
end

function GpMemberScene:checkCollision(member,object)
        local memberLeft = member.x
        local memberTop = member.y
        local meberRight = member.x + member.width + 20
        local memberBottom = member.y + member.height
        local itemLeft = object.x
        local itemTop = object.y
        local itemRight = object.x + object.width
        local itemBottom = object.y + object.height
        if meberRight > itemLeft and memberLeft < itemRight and memberBottom > itemTop and memberTop < itemBottom then
            return true
        else
            return false
        end    
end

function GpMemberScene:update(dt)
    local touch = false
    
    for _, button in ipairs(buttons) do
        button:update()
    end
    
    for _, member in ipairs(members) do
        member:update(dt)
    end

    for _,object in ipairs(self.list_of_set) do
        object:update()
    end

    for _,object in ipairs(self.list_of_object) do
        object:update()
        touch = GpMemberScene:checkCollision(MemberL,object)
        if love.keyboard.isDown(moduleParam.handL_interaction) and touch == true then
            object:callback()
        end
    end

    for _,object in ipairs(self.list_of_object) do
        object:update()
        touch = GpMemberScene:checkCollision(MemberR,object)
        if love.keyboard.isDown(moduleParam.handR_interaction) and touch == true then
            object:callback()
        end
    end

    if love.keyboard.isDown("escape") then
        moduleScene.oldScene = moduleScene.currentScene
        moduleScene.currentScene = PauseScene
    end

end

function GpMemberScene:draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
    for _,object in ipairs(self.list_of_set) do
        object:draw()
    end
    for _,object in ipairs(self.list_of_object) do
        object:draw()
    end
    for _, member in ipairs(members) do
        member:draw()
    end
    
end

return GpMemberScene