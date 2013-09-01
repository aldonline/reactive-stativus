
# Add reactivity to Stativus

```coffeescript

# add reactivity to Stativus
rs = require 'reactive-stativus'

# pass in the global Stativus object
rs Stativus

# create your statecharts as usual
sc = Stativus.createStatechart()
sc.addState ...
sc.initStates ...

# hey look. Stativus grew a new method!

sc.in('my_state') # true

# and guess what. It is reactive!

reactivity.subscribe ( -> sc.in('my_state') ), (e, r) -> console.log e, r

```


# Bonus feature: Use coffeescript to configure your statecharts

```coffeescript
# TODO. docs
# see tests for now
```
