local visual = {}

visual.ball = System( {"_entity", "-position", "-width", "-height", "-velocity", "-angle", "!control"}, function(e)
  local center = vector(e.position.x + e.width/2, e.position.y + e.height/2)

  love.graphics.circle("fill", center.x, center.y, 5, 10)
end  )

visual.bricks = System( {"position", "width", "height", "!velocity"}, function(position, width, height)
  love.graphics.rectangle("fill", position.x, position.y, width, height)
end )

visual.paddle = System( {"position", "width", "height", "control"}, function(position, width, height)
  love.graphics.rectangle("fill", position.x, position.y, width, height)
end )

visual.score = function()
  love.graphics.print(score)
end

--Extra visual functions with Observer-pattern
Signal.register( "floorHit", function()
  love.graphics.setBackgroundColor(100, 0, 25)
end )

return visual
