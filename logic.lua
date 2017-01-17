local logic = {}

logic.movement = System( {"_entity", "-position", "-angle", "-velocity"}, function(e, dt)
  local x = e.position.x + e.velocity * e.angle.x * dt
  local y = e.position.y + e.velocity * e.angle.y * dt

  local cols = nil
  e.position.x, e.position.y, cols = spawn.world:move(e, x, y, collision.filter)

  for i,v in ipairs(cols) do
    local f = v.other
    local normal = vector(v.normal.x, v.normal.y)
    local event = spawn.form(e).."X"..spawn.form(f)

    Signal.emit(event, e, f, normal)
  end
end )

logic.control = System( {"_entity", "-control", "-angle"}, function(e, dt)
  e.angle.x = 0

  if command.left then e.angle.x = e.angle.x - 1 end
  if command.right then e.angle.x = e.angle.x + 1 end
end )

logic.borders = System( {"_entity", "-position", "-velocity", "-angle"}, function(e, dt)
  if e.position.y > love.graphics.getHeight() - e.height then
    e.position.y = love.graphics.getHeight() - e.height
    e.angle.y = e.angle.y * -1
    Signal.emit("floorHit")
  end

  if e.position.y < 0 then
    e.position.y = 0
    e.angle.y = e.angle.y * -1
    Signal.emit("ceilingHit")
  end

  if e.position.x > love.graphics.getWidth() - e.width then
    e.position.x = love.graphics.getWidth() - e.width
    e.angle.x = e.angle.x * -1
    Signal.emit("rightWallHit")
  end

  if e.position.x < 0 then
    e.position.x = 0
    e.angle.x = e.angle.x * -1
    Signal.emit("leftWallHit")
  end
end )

logic.record = function()
  command = {}

  if love.keyboard.isDown("a") then command.left = true end
  if love.keyboard.isDown("d") then command.right = true end

  if commands == nil then commands = {} end
  table.insert(commands, command)
end

logic.replay = function()
  if commands == nil then
    commands = bitser.loads( love.filesystem.read("recording.demo") )
  end

  command = table.remove(commands, 1)

  if snapshots and tick.tick == snapshots[1] then
    love.graphics.clear()
    love.draw()

    love.graphics.newScreenshot():encode("png", "frame_"..tick.tick.."_.png")
    print("Screenshot saved!")
    table.remove(snapshots, 1)
  end

  if command == nil then
    love.event.quit()
    command = {}
    --frame will still run to the end
  end
end

logic.remove = function(entities)
  for i,v in ipairs(entities) do
    if v.remove then
      table.remove(entities, i)
      spawn.world:remove(v)
    end
  end
end

return logic
