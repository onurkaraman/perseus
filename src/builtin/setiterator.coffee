class SetIterator extends Iterator
  constructor: (set) ->
    @iterable = set.value.keys() # set contains a value attribute which is a hashset
    @index = 0

  next: ->
    if @index >= @iterable.length
      (new StopIteration "StopIteration").raise()
    else
      return @iterable[@index++]