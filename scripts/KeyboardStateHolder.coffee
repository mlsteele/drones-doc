key_states = {}

# keep track of keys held down
# uses Mousetrap internally
window.KeyboardStateHolder =
  # key is a string or a list of strings to subscribe to
  subscribe: (key) ->
    # if it's a list
    if (typeof key) isnt 'string'
      @subscribe k for k in key
    else
      key_states[key] = false

      Mousetrap.bind key, (-> keySet true)
      Mousetrap.bind key, (-> keySet false), 'keyup'

      keySet = (state) ->
        # console.log key, state
        key_states[key] = state
        return false

  # Check whether a key is currently down.
  # true if the key is subscribed and down
  # false if the key is up or has not been subscribed to
  getState: (key) ->
    key_states[key] is true
