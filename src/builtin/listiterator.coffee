class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list.value
    @index = 0

  next: ->
    if @index >= @iterable.length
      (new StopIteration "StopIteration").raise()
    else
      return @iterable[@index++]