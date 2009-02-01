function load()
  boing = love.audio.newSound("boing.wav")
  love.audio.setVolume(0.3)

  font = love.graphics.newFont(love.default_font, 12)
  love.graphics.setFont(font)

  world = love.physics.newWorld(20000, 20000)
  world:setGravity(0, 50)
end

function update(dt)
  world:update(dt)
end

function draw()
end

function keypressed(k)
end
