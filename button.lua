local Button = {}

function Button:new(x, y, width, height, color, text, colorText ,callback,arg1)
  local button = {
      x = x,
      y = y,
      width = width,
      height = height,
      color = color,
      text = text,
      colorText = colorText,
      callback = callback,
      arg1 = arg1,
      state = false,
  }
  setmetatable(button, self)
  self.__index = self
  return button
end

function Button:draw()
  local color = self.hover and {0.8, 0.8, 0.8} or self.color
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  if self.hover then
      love.graphics.setColor(1, 1, 1)
      love.graphics.rectangle("line", self.x-1, self.y-1, self.width+2, self.height+2)
  end
  if self.state == true then
      self.callback(self)
      self.state = false
  end
  -- Affichage du texte
  love.graphics.setColor(self.colorText) -- couleur du texte noir
  local scale = self.height / 50
  local font = love.graphics.newFont(12*scale) 
  love.graphics.setFont(font)
  if  self.text == nil then
  else
    love.graphics.printf(self.text, self.x, self.y + self.height / 2 - 10, self.width, "center")
  end
end

function Button:update(dt)
  -- On récupère la position de la souris
  local mouseX, mouseY = love.mouse.getPosition()
  -- On vérifie si la souris est dans la zone du bouton
  self.hover = mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
  if self.hover and love.mouse.isDown(1) and self.state == false then
      self.state = true
  end
end


return Button