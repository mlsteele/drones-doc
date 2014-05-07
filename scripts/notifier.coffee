class Notifier
  @CSS_CLASS = 'notifier-widget'
  @CSS_VISIBLE = 'notifier-visible'

  constructor: (@$el) ->
    @$el.addClass Notifier.CSS_CLASS

  show: (@text, timeout) ->
    @$el.text @text
    @$el.addClass(Notifier.CSS_VISIBLE)
    clearTimeout @activeTimeout
    if timeout
      later = =>
        @$el.removeClass(Notifier.CSS_VISIBLE)
      @activeTimeout = setTimeout later, timeout


window.Notifier = Notifier
