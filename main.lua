System    = require 'libs.knife.system'
Signal    = require 'libs.hump.signal'
vector    = require 'libs.hump.vector'
tick      = require 'libs.bjornbytes.tick'
bump      = require 'libs.kikito.bump'
bitser    = require 'libs.gvx.bitser'

logic     = require 'logic'
visual    = require 'visual'
spawn     = require 'spawn'
collision = require 'collision'

input = "record"
love.filesystem.setIdentity("RecordOut")
print("Save location: "..love.filesystem.getSaveDirectory() )

function love.load(arg)
  if arg[2] then input = "replay" end
  if arg[4] then
    snapshots = {}

    for i = 4,#arg do
      table.insert(snapshots, tonumber(arg[i]))
    end
  end

  tick.rate = 1/144
  tick.timescale = arg[3] or 1

  spawn.ball{position = vector(400,400), angle = vector(0,1)}
  spawn.paddle{}

  score = 0

  for i = 0,14 do
    for j = 0,9 do
      spawn.brick{position = vector(168 + 31 * i, 150 + 16 * j)}
    end
  end
end

function love.update(dt)
  for _,operation in ipairs{input, "control", "movement", "borders", "remove"} do
    logic[operation](spawn.entities, dt)
  end
end

function love.draw()
  for _,operation in ipairs{"bricks", "paddle", "ball", "score"} do
    visual[operation](spawn.entities)
  end
end

function love.quit()
  if input == "record" then
    love.filesystem.write( "recording.demo", bitser.dumps(commands) )
  end
end
