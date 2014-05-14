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

  stop: ->
    @vel = Vec2 0, 0
    @tilt = Vec2 0, 0

# class DroneView

#   constructor: (@model) ->
#     @domElement = $ "<div class='drone'>"

#     $("#arena").append @domElement

#     @domElement.sprite
#       fps: 40
#       no_of_frames: 10

#   update: ->
#     @domElement.css
#       'left': "#{@model.pos.x}px"
#       'top': "#{@model.pos.y}px"
#       '-webkit-transform': "perspective(50px)
#                             rotateX(#{-@model.vel.y * 10}deg)
#                             rotateY(#{ @model.vel.x * 10}deg)"

class DroneMarkerView
  @PIXELS_PER_LAT = 0.000007
  @PIXELS_PER_LNG = 0.00001

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
    lat = @initialLatLng.lat + DroneMarkerView.PIXELS_PER_LAT * -@model.pos.y
    lng = @initialLatLng.lng + DroneMarkerView.PIXELS_PER_LNG * @model.pos.x
    @marker.setLatLng [lat, lng]

    @domElement.css
      '-webkit-transform': "perspective(50px)
                            rotateX(#{-@model.vel.y * 10}deg)
                            rotateY(#{ @model.vel.x * 10}deg)"
  getLatLng: ->
    @marker.getLatLng()

  getScreenPosition: ->
    Vec2 @domElement.position().left, @domElement.position().top

disable_map_interactivity = (map) ->
  map.keyboard.disable()
  map.dragging.disable()
  map.touchZoom.disable()
  map.doubleClickZoom.disable()
  map.scrollWheelZoom.disable()
  if map.tap then map.tap.disable()


$ ->
  # console.log 'welcome'

  # introduction
  $("#continue").click ->
    $("#intro").fadeOut()
    return false

  notifier = new Notifier $ "#notification-widget"
  window.notifier = notifier
  NOTIFICATION_TIMEOUT = 4000 # milliseconds
  # pending_notification = undefined # string to notify on video close

  KeyboardStateHolder.subscribe ['up', 'down', 'left', 'right']


  # setup map
  viewCenter = [42.3609, -71.0904]
  viewZoom = 18
  map = L.mapbox.map('arena', 'seveneightn9ne.i60f72a6', {zoomControl: false}).setView(viewCenter, viewZoom)
  disable_map_interactivity(map)

  # create game objects
  droneModel = new DroneModel 100, 100
  droneView = new DroneMarkerView droneModel, map
  achievements = []

  # add zones
  zones = {}
  for name of window.people
    zone_color = window.people[name].zone_color
    zones[name] = L.geoJson(window.buildings_geojson[name]).addTo(map)
    zones[name].setStyle 'color': zone_color

  marker_layers = []

  drone_running = true
  refresh_display = ->
    window.requestAnimationFrame refresh_display
    if drone_running
      droneModel.update()
      droneView.update()

      # sketchy boundary detection
      # drive the drone back towards safety
      BOUNDARY_PADDING = 75 # pixels
      if droneView.getScreenPosition().x < BOUNDARY_PADDING
        droneModel.tilt = Vec2 DroneModel.TILT_MAX, 0
      if droneView.getScreenPosition().y < BOUNDARY_PADDING
        droneModel.tilt = Vec2 0, DroneModel.TILT_MAX
      if $('#arena').width() - droneView.getScreenPosition().x < BOUNDARY_PADDING
        droneModel.tilt = Vec2 -DroneModel.TILT_MAX, 0
      if $('#arena').height() - droneView.getScreenPosition().y < BOUNDARY_PADDING
        droneModel.tilt = Vec2 0, -DroneModel.TILT_MAX

      # check whether the drone is in a zone
      for name of window.people
        zone = zones[name]
        inZone = leafletPip.pointInLayer(droneView.getLatLng(), zone, true)
        if (inZone.length != 0)
          # a hit, a very palpable hit!
          on_zone_hit name

      # check whether the drone hits a marker
      for marker_layer in marker_layers
        for marker_id of marker_layer._layers
          marker = marker_layer._layers[marker_id]
          if marker.getLatLng().distanceTo(droneView.getLatLng()) < 15
            if marker.has_been_hit != true
              marker_layer.seen_markers += 1
              marker_hit marker
              # console.log marker_layer
              if marker_layer.seen_markers == marker_layer.max_markers
                get_achievement "Explored all of #{marker_layer.name}'s videos!", ""
    else
      droneModel.stop()
      droneView.update()



  # record which zones have already been visited
  already_visited_zone = {}

  on_zone_hit = (name) ->
    # console.log "inside #{name} zone"
    unless already_visited_zone[name]?
      # mark the zone as visited
      already_visited_zone[name] = true
      show_markers(name)
      show_video window.people[name].videos['intro-video'].vimeo_id
      display_name = window.people[name].display_name
      get_achievement "Discovered #{display_name}!", "New videos have been revealed on the map!"

  # make somebodies markers appear
  show_markers = (name) ->
    console.log "show_markers(#{name})"
    marker_data = window.people_markers[name]
    markers_layer = L.geoJson(marker_data)
    set_markers_icons markers_layer, window.people[name].marker_color
    markers_layer.name = window.people[name].display_name
    markers_layer.max_markers = marker_data['features'].length
    markers_layer.seen_markers = 0
    marker_layers.push markers_layer.addTo(map)

  set_markers_icons = (markers_layer, color) ->
    # console.log markers_layer
    for marker_id of markers_layer._layers
      marker = markers_layer._layers[marker_id]
      name = marker.feature.properties['video-person-name']
      video_shortname = marker.feature.properties['video-id']
      label = window.people[name].videos[video_shortname].label
      marker.setIcon new L.HtmlIcon
        html: "<div class='marker-vid marker-icon-#{color}'><div class='#{video_shortname}-label marker-vid-label'>#{label}</div>"

  marker_hit = (marker) ->
    # console.log "hit marker!"
    if marker.has_been_hit != true
      marker.setIcon new L.HtmlIcon
        html: "<div class='marker-vid marker-icon-gray'></div>"
      marker.has_been_hit = true
      name = marker.feature.properties['video-person-name']
      #   console.log name
      video_shortname = marker.feature.properties['video-id']
      #   console.log video_shortname
      label = window.people[name].videos[video_shortname].label
      #   highlight_markers_with_label label
      highlight_similar_markers video_shortname
      show_video window.people[name].videos[video_shortname].vimeo_id

  highlight_similar_markers = (video_shortname) ->
    # outerloop:
    shortnames = false
    for category of window.marker_relationships
      for sn in window.marker_relationships[category]
        $(".#{sn}-label").removeClass("highlight")
        if sn == video_shortname
          shortnames = window.marker_relationships[category]
    if shortnames
      for shortname in shortnames
        $(".#{shortname}-label").addClass("highlight")
    # for marker_layer in marker_layers
    #   for marker_id of marker_layer._layers
    #     marker = marker_layer._layers[marker_id]
    #     name = marker.feature.properties['video-person-name']
    #     color = window.people[name].marker_color
    #     video_shortname = marker.feature.properties['video-id']
    #     this_label = window.people[name].videos[video_shortname].label
    #     if video_shortname in shortnames
    #       marker.setIcon new L.HtmlIcon
    #         html: "<div class='highlight marker-vid marker-icon-#{color}'><div class='marker-vid-label'>#{this_label}</div>"
    #     else
    #       marker.setIcon new L.HtmlIcon
    #         html: "<div class='marker-vid marker-icon-#{color}'><div class='marker-vid-label'>#{this_label}</div>"

  # display a vimeo video
  show_video = (id) ->
    drone_running = false
    $.fancybox({
      'helpers': {
        'media': {}
      }
      'autoScale': true,
      'transitionIn': 'elastic',
      'transitionOut': 'elastic',
      'speedIn': 500,
      'speedOut': 300,
      'autoDimensions': true,
      'centerOnScroll': true,
      'href' : "http://vimeo.com/" + id,
      'afterClose': ->
        drone_running = true
        # if pending_notification
          # notifier.show pending_notification, NOTIFICATION_TIMEOUT

        Mousetrap.bind 'enter', -> $("#continue").click()
        Mousetrap.bind 'space', -> $("#continue").click()
        Mousetrap.bind 'esc', -> $("#continue").click()
        return true
      })

  show_video(95301752)
  already_got_achievement = (title) ->
    for achievement in achievements
      if achievement == title
        return true
    return false

  get_achievement = (title, info) ->
    if achievements.length == 0 #first achievement
      $("#achievements small").hide()
      $("#achievements").append($("<ul>"))
    if not already_got_achievement(title)
      achievements.push title
      $("#achievements ul").append($("<li>").html("<b>#{title}</b> #{info}"))

  # start the main loop
  refresh_display()
