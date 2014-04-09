class DroneModel
  @TILT_TYPICAL: 0.04
  @TILT_MAX: 0.1
  @VEL_MAX: 3

  constructor: (x, y) ->
    @pos = Vec2 x, y
    @vel = Vec2 0, 0
    @tilt = Vec2 0, 0

  update: ->
    @_controls()

    @vel.add @tilt
    @pos.add @vel
    @tilt.add @vel.multiply(-0.002, yes)
    @tilt.multiply 1 - 0.03

    if @tilt.length() > DroneModel.TILT_MAX
      @tilt.multiply (DroneModel.TILT_MAX / @tilt.length())
    if @vel.length() > DroneModel.VEL_MAX
      @vel.multiply (DroneModel.VEL_MAX / @vel.length())

  # update controls from keyboard
  _controls: ->
    thrust = DroneModel.TILT_TYPICAL / 10

    if KeyboardStateHolder.getState 'up'
      @tilt.add Vec2 0, -thrust

    if KeyboardStateHolder.getState 'down'
      @tilt.add Vec2 0, +thrust

    if KeyboardStateHolder.getState 'left'
      @tilt.add Vec2 -thrust, 0

    if KeyboardStateHolder.getState 'right'
      @tilt.add Vec2 +thrust, 0

$ ->
  console.log 'welcome'

  player_drone = new DroneModel 100, 100

  KeyboardStateHolder.subscribe ['up', 'down', 'left', 'right']

  refresh_display = ->
    player_drone.update()
    # $('#debugtext').html "pos: #{player_drone.pos.toString()}<br/>
    #                       vel: #{player_drone.vel.toString()}<br/>
    #                       tilt: #{player_drone.tilt.toString()}"

    $('.drone').css 'left', "#{player_drone.pos.x}px"
    $('.drone').css 'top', "#{player_drone.pos.y}px"
    # $('.drone').css '-webkit-transform', "rotateX(#{player_drone.vel.x * 10000}deg)"
    # $('.drone').css '-webkit-transform', "rotateY(#{player_drone.vel.y * 10000}deg)"
    $('.drone').css '-webkit-transform', "perspective(50px)
                                          rotateX(#{-player_drone.vel.y * 10}deg)
                                          rotateY(#{ player_drone.vel.x * 10}deg)"

    window.requestAnimationFrame refresh_display

  refresh_display()

  # Mousetrap.bind 'up', ->
  #   player_drone.tilt.add Vec2 0, -DroneModel.TILT_TYPICAL

  # Mousetrap.bind 'down', ->
  #   player_drone.tilt.add Vec2 0, +DroneModel.TILT_TYPICAL

  # Mousetrap.bind 'left', ->
  #   player_drone.tilt.add Vec2 -DroneModel.TILT_TYPICAL, 0

  # Mousetrap.bind 'right', ->
  #   player_drone.tilt.add Vec2 +DroneModel.TILT_TYPICAL, 0
