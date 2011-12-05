class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list.copy()
    @index = 0

  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)