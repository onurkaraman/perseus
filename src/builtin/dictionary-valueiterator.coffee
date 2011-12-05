class DictionaryValueIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.values()
    @index = 0

  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)