class SetIterator extends Iterator
  constructor: (set) ->
    @iterable = set.value.keys() # set contains a value attribute which is a hashset
    @index = 0

  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)