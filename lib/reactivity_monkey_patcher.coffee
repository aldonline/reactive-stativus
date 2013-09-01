rcell = require 'reactive-cell'
###
adds reactivity to a statechart by monkey patching
the internal API.
You must pass in the global Stativus object
Note: this may break in different versions of Stativus
###
create_overrider = ( obj ) -> ( name ) ->
  old = obj[name]
  obj[name] = ->
    old.apply @, arguments
    @__tick()

module.exports = ( Stativus ) ->

  # monkey patch state
  S = Stativus.State
  overr = create_overrider S
  overr 'goToState'
  overr 'goToHistoryState'
  overr 'sendEvent'
  overr 'sendAction'
  S.__tick = -> @statechart.__tick()

  # monkey patch statechart  
  SC = Stativus.Statechart
  overr = create_overrider SC
  overr 'initStates'
  overr 'goToState'
  overr 'goToHistoryState'
  overr 'sendEvent'

  SC.__tick = ->
    for state_name, cell of @__cells
      cell find_state state_name, @currentState()
    undefined

  # this is THE reactive method
  # NOTE: we could add reactivity to currentState, data, etc
  SC.in = (state_name) ->
    cs = ( @__cells ?= {} )
    unless ( c = cs[state_name] )?
      c = cs[state_name] = rcell()
      c find_state state_name, @currentState()
    c()

find_state = ( state_name, states ) ->
  return yes for s in states when s.name is state_name
  no


