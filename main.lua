--PADS
pad1 = {}
pad1.x = 0
pad1.y = 0
pad1.width = 20
pad1.height = 80


pad2 = {}
pad2.x = 0
pad2.y = 0
pad2.width = 20
pad2.height = 80

--BALL
ball = {}
ball.x = 400
ball.y = 300
ball.width = 20
ball.height = 20
ball.speed_x = 3.5
ball.speed_y = 3.5


function CenterBall()
  --position
  ball.x = love.graphics.getWidth() / 2 - ball.width / 2
  ball.y = love.graphics.getHeight() / 2 - ball.height / 2
  --speed
  ball.speed_x = 3.5
  ball.speed_y = 3.5
end

function love.load()
  CenterBall()
  
  pad1.x = 0
  pad1.y = 0
  
  pad2.x = love.graphics.getWidth() - pad2.width
  pad2.y = love.graphics.getHeight() - pad2.height
end

function love.update()
  
  --PADS controls and limits START

  --PADS 1(left corner, player1)
  if love.keyboard.isDown('s') and pad1.y + pad1.height < love.graphics.getHeight()  then 
    pad1.y = pad1.y + 3.5
  end

  if love.keyboard.isDown('z') and pad1.y > 0 then 
    pad1.y = pad1.y - 3.5
  end
  --PADS 2(right corner, player1)
  if love.keyboard.isDown('down') and pad2.y + pad2.height < love.graphics.getHeight() then 
    pad2.y = pad2.y + 3.5
  end

  if love.keyboard.isDown('up') and pad2.y > 0 then 
    pad2.y = pad2.y - 3.5 
  end
  --PADS controls and limits END


  --Ball Speed and Bounce START
  ball.x = ball.x + ball.speed_x
  ball.y = ball.y + ball.speed_y

  if ball.x < 0 then
    CenterBall()
  end
  if ball.y < 0 then 
    ball.speed_y = ball.speed_y * -1
  end

  if ball.x > love.graphics.getWidth() - ball.width then
      CenterBall()
  end
  if ball.y > love.graphics.getHeight() - ball.height then
    ball.speed_y = -ball.speed_y
  end
  --Ball Speed and Bounce END


  --Ball and Pads collision START
  if ball.x <= pad1.x + pad1.width then 
    if ball.y + ball.height > pad1.y and ball.y < pad1.y + pad1.height then
      ball.speed_x = -ball.speed_x
      ball.x = pad1.x + pad1.width
    end
  end
  --Ball and Pads collision END
  if ball.x + ball.width > pad2.x then
    if ball.y + ball.height > pad2.y and ball.y < pad2.y + pad2.height then
      ball.speed_x = ball.speed_x * -1
    end
  end

end

function love.draw()
  --PAD 1
  player1 = love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width,pad1.height)
  --PAD 2
  player2 = love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
  --BALL
  theBall = love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end