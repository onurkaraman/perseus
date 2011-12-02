class DictionaryKeyIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.keys()
    @index = 0

  next: ->
    if @index >= len(@iterable)
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)