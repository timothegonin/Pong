pad = {}
pad.x = 0
pad.y = 0
pad.width = 20
pad.height = 80

function love.load()
end

function love.update()
  
  if love.keyboard.isDown('down') then 
    
    if pad.y == love.graphics.getHeight() - pad.height then
      pad.y = love.graphics.getHeight() - pad.height
    else pad.y = pad.y + 2 
    end

  end

  if love.keyboard.isDown('up') then 
    
    if pad.y == 0 then
      pad.y = 0
    else pad.y = pad.y - 2 
    end

  end


end

function love.draw()
  player1 = love.graphics.rectangle("fill", pad.x, pad.y, pad.width,pad.height)
end