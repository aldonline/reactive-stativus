Stativus = require './ext/stativus-full'
comp     = require './definition_parameter_compiler'
mp       = require './reactivity_monkey_patcher'

module.exports = create = ( opts ) ->
  params = comp opts
  mp Stativus
  sc = Stativus.createStatechart()
  sc.addState 'root', params
  sc

create.patch  = mp
create.params = comp