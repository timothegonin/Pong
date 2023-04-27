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
--trail
trailList ={}

--SCORE
score_player1 = 0
score_player2 = 0 

function CenterBall()
  --position
  ball.x = love.graphics.getWidth() / 2 - ball.width / 2
  ball.y = love.graphics.getHeight() / 2 - ball.height / 2
  --speed
  ball.speed_x = 3.5
  ball.speed_y = 3.5
end


--[[ 
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ LOAD                                                                    │
  └─────────────────────────────────────────────────────────────────────────┘
 ]]
function love.load()
  --init ball to middle
  CenterBall()
  
  --init players positions
  pad1.x = 0
  pad1.y = 0
  pad2.x = love.graphics.getWidth() - pad2.width
  pad2.y = love.graphics.getHeight() - pad2.height
end


--[[ 
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ UPDATE                                                                  │
  └─────────────────────────────────────────────────────────────────────────┘
 ]]
function love.update(dt)
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

  for index=#trailList,1,-1 do
    local trail = trailList[index]
    trail.duration = trail.duration - dt
    trail.x = trail.x + trail.speed_x
    trail.y = trail.y + trail.speed_y
    if trail.duration <= 0 then
      table.remove(trailList, index)
    end
  end 

  local newBallTrail = {}
  newBallTrail.x = ball.x
  newBallTrail.y = ball.y
  newBallTrail.speed_x = math.random(-1,1)
  newBallTrail.speed_y = math.random(-1,1)
  newBallTrail.duration = 0.35
  --(alternative colors)
  -- newBallTrail.color_red = math.random()
  -- newBallTrail.color_green = math.random()
  -- newBallTrail.color_blue = math.random()
  table.insert(trailList,newBallTrail)
  

  --Ball Speed and Bounce START
  ball.x = ball.x + ball.speed_x
  ball.y = ball.y + ball.speed_y

  --player 1 LOOSE - out left
  if ball.x < 0 then
    CenterBall()
    score_player2 = score_player2 + 1 
  end
  --player 2 LOOSE - out right
  if ball.x > love.graphics.getWidth() - ball.width then
      CenterBall()
      score_player1 = score_player1 + 1
  end

  --Top bounce 
  if ball.y < 0 then  
    ball.speed_y = ball.speed_y * -1
  end
  --Bottom bounce
  if ball.y > love.graphics.getHeight() - ball.height then
    ball.speed_y = -ball.speed_y
  end
  --Ball Speed and Bounce END


  --Ball and Pads collision START
  --(player1 - ball)
  if ball.x <= pad1.x + pad1.width then 
    if ball.y + ball.height > pad1.y and ball.y < pad1.y + pad1.height then
      ball.speed_x = -ball.speed_x
      ball.x = pad1.x + pad1.width
    end
  end
  --(player2 - ball)
  if ball.x + ball.width > pad2.x then
    if ball.y + ball.height > pad2.y and ball.y < pad2.y + pad2.height then
      ball.speed_x = ball.speed_x * -1
      ball.x = pad2.x - ball.width
    end
  end
  --Ball and Pads collision END

end


--[[ 
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ DRAW                                                                    │
  └─────────────────────────────────────────────────────────────────────────┘
 ]]
function love.draw()
  --PAD 1
  player1 = love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width,pad1.height)
  --PAD 2
  player2 = love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)

  --BALL TRAIL
  for index=1,#trailList do
    local trail = trailList[index]
    --SQUARE TRAIL
    love.graphics.setColor(1,1,1, trail.duration)
    --alternative colors
    -- love.graphics.setColor(trail.color_red,trail.color_green, trail.color_blue, trail.duration)
    love.graphics.rectangle("fill", trail.x, trail.y, ball.width, ball.height)
    --BUBBLE TRAIL
    -- love.graphics.setColor(0.5,0.5,1, trail.duration)
    -- love.graphics.circle("line", trail.x + ball.width / 2 , trail.y + ball.height / 2, ball.height / 2)
  end
  --BALL
  love.graphics.setColor(1,1,1,1)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)

  local score = score_player1.." - "..score_player2
  love.graphics.print(score, 400, 0)
end