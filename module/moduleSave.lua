local moduleSave = {}
moduleSave.path = love.filesystem.getSaveDirectory()

function moduleSave:Save(scene)
    love.filesystem.write("save.txt", scene)
end

function moduleSave:newGame()
    love.filesystem.write("save.txt", "")
end

function moduleSave:continue()
    local continueSave = love.filesystem.read("save.txt")
    return continueSave
end

return moduleSave