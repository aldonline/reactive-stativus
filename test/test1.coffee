chai       = require 'chai'
should     = chai.should()
reactivity = require 'reactivity'

X = require '../lib'

delay = -> setTimeout arguments[1], arguments[0]


build = -> X 
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
      click3: -> @goToState 'state2'


describe '', ->

  it '', ->
    
    arr = []

    sc = build()
    sc.initStates 'root'

    stop = reactivity.subscribe ( -> sc.in('state3') ), (e, r) -> arr.push r

    arr.length.should.equal 1
    arr[0].should.equal no

    sc.in('root').should.equal   yes
    sc.in('state2').should.equal yes
    sc.in('state3').should.equal no

    sc.sendEvent 'click'

    arr.length.should.equal 2
    arr[1].should.equal yes

    sc.in('root').should.equal   yes
    sc.in('state2').should.equal no
    sc.in('state3').should.equal yes

    sc.sendEvent 'click3'

    arr.length.should.equal 3
    arr[2].should.equal no

    sc.in('root').should.equal   yes
    sc.in('state2').should.equal yes
    sc.in('state3').should.equal no

    stop()


  it '', ->