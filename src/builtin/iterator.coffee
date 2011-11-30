class Iterator extends Primitive
  constructor: (@iterable) ->
  
  __iter__: ->
    return @