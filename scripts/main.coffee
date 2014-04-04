class DroneModel
  constructor: (x, y) ->
    @pos = Vec2 0, 0
    @vel = Vec2 0, 0

  update: ->
    @pos.add @vel
    @vel.multiply 0.999

$ ->
  console.log 'welcome'

  player_drone = new DroneModel 0, 0

  refresh_display = ->
    player_drone.update()
    $('.drone').css 'left', "#{player_drone.pos.x}px"
    $('.drone').css 'top', "#{player_drone.pos.y}px"
    window.requestAnimationFrame refresh_display

  refresh_display()

  Mousetrap.bind 'up', ->
    player_drone.vel.add Vec2 0, -1
    refresh_display()

  Mousetrap.bind 'down', ->
    player_drone.vel.add Vec2 0, +1
    refresh_display()

  Mousetrap.bind 'left', ->
    player_drone.vel.add Vec2 -1, 0
    refresh_display()

  Mousetrap.bind 'right', ->
    player_drone.vel.add Vec2 +1, 0
    refresh_display()
