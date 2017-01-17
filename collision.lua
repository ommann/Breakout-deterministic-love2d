local collision = {}

collision.filter = function(item, other)
  return "bounce"
end

Signal.register( "ballXbrick", function(e, f, normal)
  if normal.x ~= 0 then e.angle.x = e.angle.x * -1 end
  if normal.y ~= 0 then e.angle.y = e.angle.y * -1 end

  f.remove = true
end )

Signal.register( "ballXpaddle", function(e, f, normal)
  local depth = 25
  local anchor = f.position + vector(f.width/2, depth)
  local angle  = (e.position - anchor):normalized()

  e.angle.x, e.angle.y = angle.x, angle.y
end )

Signal.register( "ballXbrick", function(e, f, normal)
  score = score + 1
end )

return collision
