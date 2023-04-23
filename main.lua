--PADS
pad = {}
pad.width = 20
pad.height = 80
pad.x = 0
pad.y = 0

--BALL
ball = {}
ball.width = 20
ball.height = 20
ball.x = love.graphics.getWidth() / 2 - ball.width / 2
ball.y = love.graphics.getHeight() / 2 - ball.height / 2

function love.load()
end

function love.update()
  
  if love.keyboard.isDown('down') and pad.y < love.graphics.getHeight() - pad.height then 
    pad.y = pad.y + 2 
  end

  if love.keyboard.isDown('up') and pad.y > 0 then 
    pad.y = pad.y - 2 
  end

end

function love.draw()
  player1 = love.graphics.rectangle("fill", pad.x, pad.y, pad.width,pad.height)
  theBall = love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end