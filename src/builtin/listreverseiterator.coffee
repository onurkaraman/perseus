class ListReverseIterator extends Iterator
  constructor: (list) ->
    @iterable = list.value
    @index = list.__len__() - 1

  next: ->
    if @index < 0
      raise new StopIteration "StopIteration"
    else
      return @iterable[@index--]