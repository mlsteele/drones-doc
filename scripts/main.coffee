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

class DroneView

  constructor: (model, id, parent) ->
    @model = model
    @id = id
    @domElement = $ "<div id='#{id}'>"
    @domElement.css
      "position": "absolute"
      "width": "25px"
      "height": "25px"
      "background-color": "blue"
      "border": "1px solid black"
      
    $("##{parent}").append @domElement

  update: ->
    @domElement.css 
      'left': "#{@model.pos.x}px"
      'top': "#{@model.pos.y}px"
      '-webkit-transform': "perspective(50px)
                            rotateX(#{-@model.vel.y * 10}deg)
                            rotateY(#{ @model.vel.x * 10}deg)"

class AreaModel

  constructor: (name) ->
    @color = "#000000"
    @name = name

  setColor: (color) ->
    @color = color


$ ->
  console.log 'welcome'

  droneModel = new DroneModel 100, 100
  droneView = new DroneView droneModel, "drone", "arena"

  KeyboardStateHolder.subscribe ['up', 'down', 'left', 'right']

  refresh_display = ->
    droneModel.update()
    droneView.update()

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
