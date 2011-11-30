class SetIterator extends Iterator
  constructor: (set) ->
    @iterable = set.dict.keys() # set contains a value attribute which is a hashset
    @index = 0

  next: ->
    if @index >= @iterable.__len__()
      (new StopIteration "StopIteration").raise()
    else
      return @iterable.index(@index++)
