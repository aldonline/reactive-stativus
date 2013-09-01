
SERIAL = 0

module.exports =

  obj_path: obj_path = ( obj, path ) -> obj = ( obj[p] ?= {} ) while p = path.shift() ; obj

  find_lcd: find_lcd = ( path1, path2 ) ->
    p = []
    for x, i in path1
      if  x is path2[i]
        p.push x
      else
        break
    p

  is_all_uppercase: ( str ) -> str is str.toUpperCase()
  
  copy: ( obj ) -> o = {} ;  o[k] = v for own k, v of obj ; o
  
  empty: ( obj ) -> return false for k of obj ; true
  
  lazy: (f) ->
    id = '__lazy_' + SERIAL++
    -> @[id] ?= f()