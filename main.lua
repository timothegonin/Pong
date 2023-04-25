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
ball.speed_x = 2
ball.speed_y = 2

function CenterBall()
  --position
  ball.x = love.graphics.getWidth() / 2 - ball.width / 2
  ball.y = love.graphics.getHeight() / 2 - ball.height / 2
  --speed
  ball.speed_x = 2
  ball.speed_y = 2
end

function love.load()
  CenterBall()
end

function love.update()
  
  --PADS controls and limits START

  --PADS 1(left corner, player1)
  if love.keyboard.isDown('s') and pad.y < love.graphics.getHeight() - pad.height then 
    pad.y = pad.y + 2 
  end

  if love.keyboard.isDown('z') and pad.y > 0 then 
    pad.y = pad.y - 2 
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
    ball.speed_x = ball.speed_x * - 1
  end
  if ball.y > love.graphics.getHeight() - ball.height then
    ball.speed_y = ball.speed_y * - 1
  end
  --Ball Speed and Bounce END


  --Ball and Pads collision START
  if ball.x <= pad.x + pad.width then 
    if ball.y + ball.height > pad.y and ball.y < pad.y + pad.height
    then
      ball.speed_x = ball.speed_x  * -1
      ball.x = pad.x + pad.width
    end
  end
  --Ball and Pads collision END

end

function love.draw()
  --PAD 1
  player1 = love.graphics.rectangle("fill", pad.x, pad.y, pad.width,pad.height)
  --BALL
  theBall = love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end