class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list.value
    @index = 0

  next: ->
    if @index >= @iterable.length
      raise new StopIteration "StopIteration"
    else
      return @iterable[@index++]