local spawn = {}

spawn.entities = {}
spawn.world = bump.newWorld()

spawn.form = function(e)
  if e.control then return "paddle" end
  if e.position and e.width and e.height and e.velocity and e.angle then return "ball" end
  if e.position and e.width and e.height then return "brick" end
  return "?"
end

local components = function(base, extension)
  local defaults = base
  local physics = extension

  return function(changes)
    local e = {}

    if defaults then
      for i,v in pairs(defaults) do
        e[i] = v
      end
    end

    if changes then
      for i,v in pairs(changes) do
        e[i] = v
      end
    end

    table.insert(spawn.entities, e)
    if physics == "physics" then
      spawn.world:add(e, e.position.x, e.position.y, e.width, e.height)
      return e
    end

    return e
  end
end

spawn.ball = components( {
  position = vector(100,100),
  width = 10,
  height = 10,
  angle = vector(1,1),
  velocity = 200,
}, "physics" )

spawn.paddle = components( {
  position = vector(350,580),
  width = 100,
  height = 20,
  velocity = 375,
  angle = vector(0,0),
  control = true
}, "physics" )

spawn.brick = components( {
  position = vector(100,100),
  width = 30,
  height = 15
}, "physics" )

return spawn
