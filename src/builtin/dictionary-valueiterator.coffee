class DictionaryValueIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.values()
    @index = 0

  next: ->
    if @index >= @iterable.__len__()
      (new StopIteration "StopIteration").raise()
    else
      return @iterable.index(@index++)