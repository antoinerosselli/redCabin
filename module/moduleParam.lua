local moduleParam = {}

moduleParam.fullScreen = {}
moduleParam.wScreen = {}
moduleParam.hScreen = {}
moduleParam.window_Width, moduleParam.window_Height = love.window.getDesktopDimensions()
-- Charac
moduleParam.charac_up = "z"
moduleParam.charac_down = "s"
moduleParam.charac_left = "q"
moduleParam.charac_right = "d"
moduleParam.charac_interaction = "e"
--- Hand
-- Hand Left
moduleParam.handL_up = "z"
moduleParam.handL_down = "s"
moduleParam.handL_left = "q"
moduleParam.handL_right = "d"
moduleParam.handL_interaction = "e"
-- Hand Right
moduleParam.handR_up = "i"
moduleParam.handR_down = "k"
moduleParam.handR_left = "j"
moduleParam.handR_right = "l"
moduleParam.handR_interaction = "u"

function moduleParam:resetParam()
    -- Charac
    moduleParam.charac_up = "z"
    moduleParam.charac_down = "s"
    moduleParam.charac_left = "q"
    moduleParam.charac_right = "d"
    moduleParam.charac_interaction = "e"
    --- Hand
    -- Hand Left
    moduleParam.handL_up = "z"
    moduleParam.handL_down = "s"
    moduleParam.handL_left = "q"
    moduleParam.handL_right = "d"
    moduleParam.handL_interaction = "e"
    -- Hand Right
    moduleParam.handR_up = "i"
    moduleParam.handR_down = "k"
    moduleParam.handR_left = "j"
    moduleParam.handR_right = "l"
    moduleParam.handR_interaction = "u"
end

function moduleParam:setParam()
    love.filesystem.write("keys.txt", moduleParam.charac_up)
    love.filesystem.append("keys.txt", moduleParam.charac_down)
    love.filesystem.append("keys.txt", moduleParam.charac_left)
    love.filesystem.append("keys.txt", moduleParam.charac_right)
    love.filesystem.append("keys.txt", moduleParam.charac_interaction)

    love.filesystem.append("keys.txt", moduleParam.handL_up)
    love.filesystem.append("keys.txt", moduleParam.handL_down)
    love.filesystem.append("keys.txt", moduleParam.handL_left)
    love.filesystem.append("keys.txt", moduleParam.handL_right)
    love.filesystem.append("keys.txt", moduleParam.handL_interaction)

    love.filesystem.append("keys.txt", moduleParam.handR_up)
    love.filesystem.append("keys.txt", moduleParam.handR_down)
    love.filesystem.append("keys.txt", moduleParam.handR_left)
    love.filesystem.append("keys.txt", moduleParam.handR_right)
    love.filesystem.append("keys.txt", moduleParam.handR_interaction)
end

function moduleParam:getParam()
    local all_param = love.filesystem.read("keys.txt")
    -- Charac
    moduleParam.charac_up = all_param:sub(1,1)
    moduleParam.charac_down = all_param:sub(2,2)
    moduleParam.charac_left = all_param:sub(3,3)
    moduleParam.charac_right = all_param:sub(4,4)
    moduleParam.charac_interaction = all_param:sub(5,5)
--- Hand
-- Hand Left
    moduleParam.handL_up = all_param:sub(6,6)
    moduleParam.handL_down = all_param:sub(7,7)
    moduleParam.handL_left = all_param:sub(8,8)
    moduleParam.handL_right = all_param:sub(9,9)
    moduleParam.handL_interaction = all_param:sub(10,10)
-- Hand Right
    moduleParam.handR_up = all_param:sub(11,11)
    moduleParam.handR_down = all_param:sub(12,12)
    moduleParam.handR_left = all_param:sub(13,13)
    moduleParam.handR_right = all_param:sub(14,14)
    moduleParam.handR_interaction = all_param:sub(15,15)
end

return moduleParam