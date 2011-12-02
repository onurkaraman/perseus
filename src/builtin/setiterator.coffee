class SetIterator extends Iterator
  constructor: (set) ->
    @iterable = set.value.keys() # set contains a value attribute which is a hashset
    @index = 0

  next: ->
    if @index >= @iterable.length
      raise new StopIteration "StopIteration"
    else
      return @iterable[@index++]