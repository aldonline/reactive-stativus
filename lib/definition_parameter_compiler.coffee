###
Provides a coffeescript friendly way
of compiling the defintion parameters
for a Stativus statechart.
###
module.exports = ( meta ) ->
  new StateMeta(meta).stativus_config()

SPECIAL = 'concurrent initial states name'
RENAMES =
  enter: 'enterState'
  exit:  'exitState'

class StateMeta
  constructor: ( @opts, @_parent = null, @_name = null ) ->
  name: -> @_name or 'root'
  parent: -> @_parent
  is_initial: -> @opts.initial is yes
  initial_substate: -> @_iss ?= do =>
    if @substates().length is 0
      return null
    else
      return s for s in @substates() when s.is_initial()
      @substates()[0]
  substates_concurrent: -> @opts.concurrent is yes
  substates: -> @_ss ?= do =>
    if @opts.states?
      ( new StateMeta v, @, k for k, v of @opts.states )
    else
      []
  actions: ->
    ( [k, v] for k, v of @opts when k not in SPECIAL and typeof v is 'function' )

  stativus_config: ->
    x = {}
    if @name()?
      x.name = @name()

    do =>
      for a in @actions()
        [name, func] = a
        name = RENAMES[name] if name of RENAMES
        x[name] = func

    # substates
    # initialSubstate
    if @substates().length isnt 0
      x.states                 = ( s.stativus_config() for s in @substates() )
      x.initialSubstate        = @initial_substate().name()
      x.substatesAreConcurrent = @substates_concurrent()
    x

###
compile_params
  enter: -> console.log '> root'
  exit:  -> console.log '< root'
  click: -> @goToState 'state3'
  concurrent: no
  states:
    state2:
      enter: -> console.log '> state2'
      exit: ->  console.log '< state2'
    state3:
      enter: -> console.log '> state3'
      exit: ->  console.log '< state3'
###



