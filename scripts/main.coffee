class DroneModel
  constructor: (x, y) ->
    @pos = Vec2 x, y
    @vel = Vec2 0, 0
    @tilt = Vec2 0, 0

  update: ->
    @vel.add @tilt
    @pos.add @vel
    @tilt.add @vel.multiply(-0.001, yes)
    @tilt.multiply 1 - 0.02

$ ->
  console.log 'welcome'

  player_drone = new DroneModel 0, 0

  refresh_display = ->
    player_drone.update()
    $('#debugtext').html "pos: #{player_drone.pos.toString()}<br/>
                          vel: #{player_drone.vel.toString()}<br/>
                          tilt: #{player_drone.tilt.toString()}"

    $('.drone').css 'left', "#{player_drone.pos.x}px"
    $('.drone').css 'top', "#{player_drone.pos.y}px"

    window.requestAnimationFrame refresh_display

  refresh_display()

  Mousetrap.bind 'up', ->
    player_drone.tilt.add Vec2 0, -0.1

  Mousetrap.bind 'down', ->
    player_drone.tilt.add Vec2 0, +0.1

  Mousetrap.bind 'left', ->
    player_drone.tilt.add Vec2 -0.1, 0

  Mousetrap.bind 'right', ->
    player_drone.tilt.add Vec2 +0.1, 0
