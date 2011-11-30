class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list
    @index = 0

  next: ->
    if @index >= @iterable.__len__()
      (new StopIteration "StopIteration").raise()
    else
      return @iterable.index(@index++)