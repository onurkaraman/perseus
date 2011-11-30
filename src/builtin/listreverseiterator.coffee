class ListReverseIterator extends Iterator
  constructor: (list) ->
    @iterable = list
    @index = list.__len__() - 1

  next: ->
    if @index < 0
      (new StopIteration "StopIteration").raise()
    else
      return @iterable.index(@index--)