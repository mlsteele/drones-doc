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

  constructor: (@model) ->
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

class DroneMarkerView
  @PIXELS_PER_L = 0.00001

  constructor: (@model, @map) ->

    droneHtmlIcon = new L.HtmlIcon
      html: "<div class='drone'> </div>"

    @marker = L.marker @map.getCenter(),
      icon: droneHtmlIcon
    # @marker.setIcon(L.icon({iconUrl: '/images/drone-spritesheet.png'}))
    @marker.addTo(@map)

    # TODO this will get all drones!
    @domElement = $('.drone')
    @domElement.sprite
      fps: 40
      no_of_frames: 10

    @initialLatLng = @marker.getLatLng()

  update: ->
    lat = @initialLatLng.lat + DroneMarkerView.PIXELS_PER_L * -@model.pos.y
    lng = @initialLatLng.lng + DroneMarkerView.PIXELS_PER_L * @model.pos.x
    @marker.setLatLng [lat, lng]

    @domElement.css
      '-webkit-transform': "perspective(50px)
                            rotateX(#{-@model.vel.y * 10}deg)
                            rotateY(#{ @model.vel.x * 10}deg)"
  point: ->
    @marker.getLatLng()

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
    lastSelected = @selected

    droneX = droneModel.pos.x
    droneY = droneModel.pos.y
    if (droneX >= @pos.x && droneX <= (@pos.x + @size.x) && droneY >= @pos.y && droneY <= (@pos.y + @size.y))
      @selected = true
    else
      @selected = false

    if @selected and not lastSelected
      $(document).trigger 'enterArea'

    if not @selected and lastSelected
      $(document).trigger 'leaveArea'

    return @selected

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

  $("#continue").click ->
    $("#intro").hide()
    return false

  viewCenter = [42.3612, -71.0904]
  viewZoom = 18
  map = L.mapbox.map('arena', 'seveneightn9ne.i57k33on').setView(viewCenter, viewZoom)

  # disable interactivity
  map.keyboard.disable()
  map.dragging.disable()
  map.touchZoom.disable()
  map.doubleClickZoom.disable()
  map.scrollWheelZoom.disable()
  if map.tap then map.tap.disable()

  zones = L.geoJson(window.buildings_geojson).addTo(map)
  marker_layers = []

  width = $("#arena").width()
  height = $("#arena").height()

  droneModel = new DroneModel 100, 100
  droneView = new DroneMarkerView droneModel, map

  KeyboardStateHolder.subscribe ['up', 'down', 'left', 'right']

  $(document).on 'enterArea', ->
    $.fancybox({
      'autoScale': true,
      'transitionIn': 'elastic',
      'transitionOut': 'elastic',
      'speedIn': 500,
      'speedOut': 300,
      'autoDimensions': true,
      'centerOnScroll': true,
      'href' : "http://farm4.staticflickr.com/3745/8971419780_cb88b22947_b.jpg"
    });

  $(document).on 'leaveArea', ->
    $.fancybox.close()

  refresh_display = ->
    droneModel.update()
    droneView.update()
    inZone = leafletPip.pointInLayer(droneView.point(), zones, true)
    if (inZone.length != 0)
      marker_layers.push polygon_hit inZone[0]

    window.requestAnimationFrame refresh_display

  has_loaded =
    "Steve": false
    "Andy": false
    "Madeline": false
  polygon_hit = (polygon) ->
    name = polygon["feature"]["properties"]["title"]
    console.log name
    if not has_loaded[name]
      has_loaded[name] = true
      if name == "Andy"
        j = window.andy_markers
      else if name == "Madeline"
        j = window.madeline_markers
      else
        console.log "Unknown name " + name
        return null
      return L.geoJson(j).addTo(map)


    
  refresh_display()
