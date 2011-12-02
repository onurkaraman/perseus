class ListReverseIterator extends Iterator
  constructor: (list) ->
    @iterable = list.copy()
    @index = len(list).value - 1

  next: ->
    if @index < 0
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index--)