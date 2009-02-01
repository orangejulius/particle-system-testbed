-- Particle Systems Demo
--
-- Particle systems emit "particles", which are drawn using images.  You must
-- first load an image, then this is draw on screen.
function load()
  font = love.graphics.newFont(love.default_font, 12)
  love.graphics.setFont(font)
  
  potato = love.graphics.newImage("potato.png")

  -- Instantiates the particle system.  Requires the image to be emitted, as
  -- well as the maximum number of particles this emitter will track.
  system = love.graphics.newParticleSystem(potato, 200)

  -- How many particles to emit per second
  system:setEmissionRate(20)

  -- For how long will the particle emitter emit particles?
  -- Specified in seconds, -1 is infinitely.
  system:setLifetime(-1)

  -- For each particle, how long will it live?
  -- Alternative is to use (min, max), such that particles will die between the 2 numbers
  -- Unit is seconds.
  system:setParticleLife(5)

  -- Position of the emitter in relation to the drawing position.
  -- Moving the emitter's position does not vary the position of the living particles,
  -- but does vary the position of particles that will be emitted in the future.
  -- Drawing the particle system in a different position draws particles at a different position.
  ex, ey = 0, 0
  system:setPosition(ex, ey)

  -- These are the drawing coordinates
  dx, dy = 400, 300

  -- In which direction should particles be emitted?  0 is east, -90 is north, 90 is south, and -180, 180 is west
  system:setDirection(-90)

  -- Amount of variation of direction.  Direction will vary by +/- spread randomly.
  -- Unit is degrees, and should be from 0 to 360.
  spread = 30
  system:setSpread(spread)

  -- Speed of the particles at emission time
  speed = 50
  system:setSpeed(speed)

  -- How much gravity to apply
  system:setGravity(20)

  -- The size of the particles.  0.5 draws the images at half-size.
  system:setSize(0.50)

  -- We have to start the particle system!
  system:start()
end

function update(dt)
  -- Move the emitter's position
  if love.keyboard.isDown(love.key_w) then
    ey = ey - 1
  end
  if love.keyboard.isDown(love.key_a) then
    ex = ex - 1
  end
  if love.keyboard.isDown(love.key_s) then
    ey = ey + 1
  end
  if love.keyboard.isDown(love.key_d) then
    ex = ex + 1
  end

  -- Move the drawing position
  if love.keyboard.isDown(love.key_i) then
    dy = dy - 1
  end
  if love.keyboard.isDown(love.key_j) then
    dx = dx - 1
  end
  if love.keyboard.isDown(love.key_k) then
    dy = dy + 1
  end
  if love.keyboard.isDown(love.key_l) then
    dx = dx + 1
  end

  system:setPosition(ex, ey)
  system:setSpread(spread)
  system:setSpeed(speed)
  system:update(dt)
end

function draw()
  love.graphics.drawf("Speed: " .. speed .. "\nSpread: " .. spread .. "\nTime: " .. love.timer.getTime() .. "\nEmitter Position: (" .. ex .. ", " .. ey .. ")" .. "\nDrawing Position: (" .. dx .. ", " .. dy .. ")", 10, 10, 300)
  love.graphics.drawf("Left/Right: change emitter's spread\nUp/Down: change emitter's speed\nW, A, S, D: Move emitter in space\nI, J, K, L: Move emitter's drawing position\nSpace: Start/stop emitter\nR: Restart game\nESC: Quit", 10, 480, 300)

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
