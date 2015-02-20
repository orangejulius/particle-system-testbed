-- Particle Systems Demo
--
-- Particle systems emit "particles", which are drawn using images.  You must
-- first load an image, then this is draw on screen.
function love.load()
  font = love.graphics.newFont(love.default_font, 12)
  love.graphics.setFont(font)
  
  potato = love.graphics.newImage("pixel.png")

  -- Instantiates the particle system.  Requires the image to be emitted, as
  -- well as the maximum number of particles this emitter will track.
  system = love.graphics.newParticleSystem(potato)
  system:setColors(0, 0, 200, 50,
    200, 0, 0, 50, 
    255, 255, 0, 50,
    0,0,0, 50)

system:setBufferSize(20000)
  -- How many particles to emit per second
  system:setEmissionRate(4000)

  -- For how long will the particle emitter emit particles?
  -- Specified in seconds, -1 is infinitely.
  system:setEmitterLifetime(-1)

  -- For each particle, how long will it live?
  -- Alternative is to use (min, max), such that particles will die between the 2 numbers
  -- Unit is seconds.
  system:setParticleLifetime(1.2)

  -- Position of the emitter in relation to the drawing position.
  -- Moving the emitter's position does not vary the position of the living particles,
  -- but does vary the position of particles that will be emitted in the future.
  -- Drawing the particle system in a different position draws particles at a different position.
  ex, ey = 0, 0
  system:setPosition(ex, ey)

  -- These are the drawing coordinates
  dx, dy = love.graphics.getWidth()/2, love.graphics.getHeight() * 0.9

  -- In which direction should particles be emitted?  
  --0 is east, -90 is north, 90 is south, and -180, 180 is west
  system:setDirection(-1.6)

  -- Amount of variation of direction.  Direction will vary by +/- spread randomly.
  -- Unit is degrees, and should be from 0 to 360.
  spread = 3.14
  system:setSpread(spread)

  system:setAreaSpread(normal, 5, 5)

  -- Speed of the particles at emission time
  speed = 80
  system:setSpeed(speed)

  -- How much gravity to apply
  system:setLinearAcceleration(0, -997)

  -- The size of the particles.  0.5 draws the images at half-size.
  system:setSizes(20, 20)

  -- Sets the tangential acceleration (acceleration perpendicular to the particle's direction).
  ta = 0 
  system:setTangentialAcceleration(ta)
 
  -- Sets the radial acceleration (acceleration towards the emitter). 
  ra = 0
  system:setRadialAcceleration(ra)

  -- We have to start the particle system!
  system:start()
end

function love.update(dt)
  -- Move the emitter's position
  if love.keyboard.isDown('w') then
    ey = ey - 1
  end
  if love.keyboard.isDown('a') then
    ex = ex - 1
  end
  if love.keyboard.isDown('s') then
    ey = ey + 1
  end
  if love.keyboard.isDown('d') then
    ex = ex + 1
  end

  -- Move the drawing position
  if love.keyboard.isDown('i') then
    dy = dy - 1
  end
  if love.keyboard.isDown('j') then
    dx = dx - 1
  end
  if love.keyboard.isDown('k') then
    dy = dy + 1
  end
  if love.keyboard.isDown('l') then
    dx = dx + 1
  end
 

  -- Change radial / tangial accel. 
  if love.keyboard.isDown('m') then
    ta = ta + 1
  end
  if love.keyboard.isDown('n') then
    ta = ta - 1
  end

  if love.keyboard.isDown('b') then
    ra = ra + 1
  end
  if love.keyboard.isDown('v') then
    ra = ra - 1
  end
 
  system:setRadialAcceleration(ra)
  system:setTangentialAcceleration(ta)
  system:setPosition(ex, ey)
  system:setSpread(spread)
  system:setSpeed(speed)
  system:update(dt)
end

function love.draw()
  love.graphics.printf("Speed: " .. speed .. "\nSpread: " .. spread .. "\nTangential acceleration: " .. ta .."\nRadial acceleration: " .. ra .."\nTime: " .. love.timer.getTime() .. "\nEmitter Position: (" .. ex .. ", " .. ey .. ")" .. "\nDrawing Position: (" .. dx .. ", " .. dy .. ")", 10, 10, 300)
  love.graphics.printf("Left/Right: change emitter's spread\nUp/Down: change emitter's speed\nV/B, N/M: radical, tangential accelerationi\nW, A, S, D: Move emitter in space\nI, J, K, L: Move emitter's drawing position\nSpace: Start/stop emitter\nR: Restart game\nESC: Quit", 10, 480, 300)

  -- Drawing the particle system last, so it appears above the text
  love.graphics.draw(system, dx, dy)
end

function keypressed(k)
  if k == love.key_escape then
    love.system.exit()
  elseif k == love.key_r then
    love.system.restart()
  elseif k == love.key_p then
    system:pause()
  elseif k == love.key_up then
    speed = speed + 10
  elseif k == love.key_down then
    speed = speed - 10
  elseif k == love.key_right then
    spread = spread + 10
  elseif k == love.key_left then
    spread = spread - 10
  elseif k == love.key_space then
    if system:isActive() then
      system:stop()
    else
      system:start()
    end
  end
end
