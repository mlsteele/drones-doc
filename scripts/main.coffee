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

  constructor: (model) ->
    @model = model
    @domElement = $ "<div class='drone'>"

    $("#arena").append @domElement

    @domElement.sprite
      fps: 40
      no_of_frames: 10

  update: ->
    @domElement.css
      'left': "#{@model.pos.x}px"
      'top': "#{@model.pos.y}px"
      '-webkit-transform': "perspective(50px)
                            rotateX(#{-@model.vel.y * 10}deg)
                            rotateY(#{ @model.vel.x * 10}deg)"

class AreaModel

  constructor: (x, y, name) ->
    @size = Vec2 x, y
    @color = "#000000"
    @name = name
    @pos = Vec2 0, 0
    @selected = false

  setColor: (color) ->
    @color = color
    @

  setPos: (x, y) ->
    @pos = Vec2 x, y
    @

  detectDrone: (droneModel) ->
    droneX = droneModel.pos.x
    droneY = droneModel.pos.y
    if (droneX >= @pos.x && droneX <= (@pos.x + @size.x) && droneY >= @pos.y && droneY <= (@pos.y + @size.y))
      @selected = true
      return true
    @selected = false
    return false

class AreaView

  constructor: (model) ->
    @model = model
    @id = @model.name.replace(" ","-")
    @domElement = $ "<div class='area'>"
    $("#arena").append @domElement

  update: ->
    @domElement.width @model.size.x
    @domElement.height @model.size.y
    @domElement.css
      'border-color': @model.color
      'left': "#{@model.pos.x}px"
      'top': "#{@model.pos.y}px"
      'box-shadow': "0px 0px 25px #{@model.color}"

    if (!@model.selected)
      @domElement.css "box-shadow", "0px 0px 10px #{@model.color}"

$ ->
  console.log 'welcome'

  width = $("#arena").width()
  height = $("#arena").height()

  droneModel = new DroneModel 100, 100
  droneView = new DroneView droneModel

  areaModels = []
  areaViews = []

  for i in [0...2]
    m = new AreaModel 200, 200, "area#{i}"
    areaModels.push(m)
    areaViews.push(new AreaView m)

  areaModels[0]
    .setPos 10, 10
    .setColor "#FF0000"
  areaModels[1]
    .setPos width-210, 10
    .setColor "#0000FF"

  KeyboardStateHolder.subscribe ['up', 'down', 'left', 'right']

  refresh_display = ->
    $("#arena").height($("html").height())
    droneModel.update()
    droneView.update()

    for areaView in areaViews
      areaView.model.detectDrone(droneModel)
      areaView.update()

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
