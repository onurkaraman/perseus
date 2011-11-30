class Iterator extends Primitive
  constructor: (iterable) ->
    switch type(iterable)
      when List then return new ListIterator(iterable)
      when Set then return new SetIterator(iterable)
      when Dictionary then return new Dictionary-KeyIterator(iterable)

  __iter__: ->
    return @